module BettyResource
  class MetaData

    def models
      @models ||= BettyResource::Model.parse(Api.get('/models').parsed_response)
    end

    def model(name)
      models[name.to_s]
    end

  end
end
