# Ruby FluidDB

A simple (almost to the barebones) REST [FluidDB](http://fluidinfo.com) client written in Ruby.

Inspired by [rest-client](http://github.com/adamwiggins/rest-client) by Adam Wiggins, I wanted to make a FluidDB lib independent from any gem, but I may eventually wrap it around rest-client since it's really good.

As for now it just take care of payload conversion and sending the correct headers, but one of the next features may be the creation of a Ruby object for each element in the FluidDB taxonomy.

I'm really having fun writing this lib and playing with FluidDB, but please consider I may still change the interface.

The code is on github, that means everyone can fork it and contribute ;) 

## Usage:

    require 'fluiddb'
    db = FluidDB::Client.new({:user => "username", :password => "password"})
    db["objects"].get({"query" => "has onigiri/likes"})
    
    db["tags/onigiri"].post({"name" => "mail", "description"=>"mail address", "indexed" => false})
    db["tags/onigiri/mail"].get
    db["tags/onigiri/mail"].delete
      
For more info about the API, go to: http://api.fluidinfo.com/fluidDB/api/*/*/*
  
  
## Alternative Usage:

    onigiri_tags = FluidDB::Client.new({:suburl => "tags/onigiri", :user => "username", :password => "password"})
    
    onigiri_tags.post({"name" => "mail", "description"=>"mail address", "indexed" => false})
  

## TODO and known issues:

It doesn't return HTTP response codes. (see delete for an example)

## Credits

Written by Emanuel Carnevale (emanuel.carnevale at gmail dot com)

Released under the [MIT License](http://www.opensource.org/licenses/mit-license.php)

[http://github.com/ecarnevale/rb-fluiddb](http://github.com/ecarnevale/rb-fluiddb)

