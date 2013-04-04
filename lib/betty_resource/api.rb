module BettyResource
  class Api
    include HTTParty

    base_uri "#{BettyResource.config.host}/api"
    format :json
    basic_auth BettyResource.config.user, BettyResource.config.password
    query_string_normalizer proc{|query|
      query.to_json
    }
  end
end