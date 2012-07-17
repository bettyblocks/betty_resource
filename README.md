# BettyResource

Map Betty5 application resources to Ruby objects through the JSON API!

## Introduction

This gem is created to map resources directly to the Betty5 API with ease. Just include the gem in your Gemfile, configure the Betty5 API credentials and your good to go!

## Setting up / Updating the environment

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

## Testing

Run the following command for testing:

    $ rake

You can also run a single test:

    $ ruby test/unit/test_betty_resource.rb

## TODO

* Typecasting of attributes

## Contact us

For support, remarks and requests, please mail us at [techteam@holder.nl](mailto:techteam@holder.nl).

## License

Copyright (c) 2012 Internetbureau Holder B.V.

[http://holder.nl](http://holder.nl) - [info@holder.nl](mailto:info@holder.nl)