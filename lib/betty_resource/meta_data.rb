class MetaData
  include HTTParty

  base_uri "#{BettyResource.config.host}/api"
  format :json
  basic_auth BettyResource.config.user, BettyResource.config.password

  def initialize
    @models = BettyResource::Model.parse(self.class.get("/models").parsed_response)
  end

  def model(name)
    @models[name.to_s]
  end

end