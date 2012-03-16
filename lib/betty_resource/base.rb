module BettyResource
  class Base
    include HTTParty

    base_uri "#{BettyResource.config.host}/api"
    format :json
    basic_auth BettyResource.config.user, BettyResource.config.password
  end
end