require 'json'
require 'net/http'
require 'uri'

module FluidDB
  class << self
    attr_accessor :base_url
  end
end

FluidDB.base_url = 'fluiddb.fluidinfo.com/'

module FluidDB
	
  class Client

  	DEFAULT_HEADERS = {'Content-type' => 'application/json', 'Accept' => 'application/json'}
    
    def initialize(options={})
      suburl = options[:suburl] ||= ""
      @user = options[:user]
      @password = options[:password]
      if(@user && @password)
        url = "http://#{@user}:#{@password}@"+FluidDB.base_url+suburl
      else
        url = "http://" + FluidDB.base_url + suburl
      end
      @uri = URI.parse(url)

    end
    
    def [](suburl)
			self.class.new({:suburl => suburl, :user => @user, :password => @password})
		end
    
    def head(payload={}, uri_args={}, additional_headers = {})
      request(:head, payload, uri_args, additional_headers)
    end
    
    def put(payload={}, uri_args={}, additional_headers = {})
      request(:put, payload, uri_args, additional_headers)
    end
    
    def get(uri_args = {}, additional_headers = {})
      request(:get, {}, uri_args, additional_headers)
    end
    
    def post(payload={}, uri_args={}, additional_headers = {})
      request(:post, payload, uri_args, additional_headers)
    end
    
    def delete(payload={}, uri_args={}, additional_headers = {})
      request(:delete, payload, uri_args, additional_headers)
    end
    
    def request(method, payload={}, uri_args={}, additional_headers = {})
      payload_methods = [:post, :put]
      if uri_args != {}
        uri_args = uri_args.inject([]){|arr,arg| arr << arg.join("=")}.join("&")
        uri_path = URI.encode(@uri.path + "?#{uri_args}")
      else
        uri_path = @uri.path
      end
      
      headers = DEFAULT_HEADERS.merge(additional_headers)
      if payload_methods.include?(method)
        payload = payload.to_json
        headers['Content-length'] = payload.size.to_s
      end
      
      req = Net::HTTP.const_get(method.to_s.capitalize).new(uri_path, headers)
      req.basic_auth(@user, @password) if @user 
      res = Net::HTTP.new(@uri.host, @uri.port).start {|http|
        if payload_methods.include?(method)
          http.request(req,payload)
        else
          http.request(req)
        end
      }
      JSON.parse(res.body) if res.body
    end
    
  end
  
end