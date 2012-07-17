module BettyResource
  class MetaData < Base

    def initialize
      @models = BettyResource::Model.parse(self.class.get("/models").parsed_response)
    end

    def model(name)
      @models[name.to_s]
    end

  end
end