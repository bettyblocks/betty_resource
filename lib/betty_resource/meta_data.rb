module BettyResource
  class MetaData

    def models
      @models ||= Api.get("/models").parsed_response.inject({}) do |models, data|
        m = BettyResource::Model.parse data
        models.merge! m.name => m
      end
    end

  end
end