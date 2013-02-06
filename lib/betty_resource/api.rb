require "httparty"

module BettyResource
  class Api
    include HTTParty
    format :json
  end
end