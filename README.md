# BettyResource

Map Betty5 application resources to Ruby objects through the JSON API!

## Introduction

This gem is created to map resources directly to the Betty5 API with ease. Just include the gem in your Gemfile, configure the Betty5 API credentials and your good to go!

## Installation

### Add `BettyResource` to your Gemfile

    gem "betty_resource"

### Install the gem dependencies

    $ bundle

### Configure the Betty5 API credentials

At first, you will need to create a user within the Betty5 application provided with an `api_password`. Ask one of the BettyBlocks developers for more information.

Afterwards, add the following in a Ruby file which gets required at startup of the application (e.g. within an `initializer`).

    BettyResource.configure do |config|
      config.host     = "https://<identifier>.bettyblocks.com"
      config.user     = <user email>
      config.password = <user api password>
    end

## Usage

Using `BettyResource` is pretty straightforward. Let's say you want to load, edit and save a record of the `Relation` model with ID 1:

    $ relation = BettyResource::Relation.get 1
    $ relation.first_name = "Paul"
    $ relation.save #=> true

## Using the console

The BettyResource repo is provided with `script/console` which you can use for development / testing purposes.

Run the following command in your console:

    $ script/console
    Loading BettyResource development environment (0.0.5)
    Configured connection with https://betty-resource-test.bettyblocks.com
    [1] pry(main)> r = BettyResource::Relation.get 1
    => #<Relation id: 1, last_name: "Willemse", first_name: "Daniel">
    [2] pry(main)> r.dirty?
    => false
    [3] pry(main)> r.first_name = "Paul"
    => "Paul"
    [4] pry(main)> r.dirty?
    => true
    [5] pry(main)> r.changes
    => {"first_name"=>["Daniel", "Paul"]}
    [6] pry(main)> r.first_name_changed?
    => true
    [7] pry(main)> r.first_name_change
    => ["Daniel", "Paul"]
    [8] pry(main)> r.first_name_was
    => "Daniel"
    [9] pry(main)> r.save
    => true
    [10] pry(main)> r.dirty?
    => false
    [11] pry(main)> BettyResource::Relation.get(r.id).first_name
    => "Paul"

## Testing

Run the following command for testing:

    $ rake

You can also run a single test:

    $ ruby test/unit/model/test_record.rb

## TODO

* Typecasting of attributes

## Contact us

For support, remarks and requests, please mail us at [support@bettyblocks.com](mailto:support@bettyblocks.com).

## License

Copyright (c) 2013 BettyBlocks B.V.

[http://bettyblocks.com](http://bettyblocks.com) - [info@bettyblocks.com](mailto:info@bettyblocks.com)