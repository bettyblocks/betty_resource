module BettyResource
  class Model < Base
    autoload :Property, "betty_resource/model/property"

    attr_accessor :id, :name, :properties

    def initialize(id, name, properties = [])
      # TODO: require id, name
      @id, @name, @properties = id, name, properties
    end

    def get(record_id)
      attributes = begin
        self.class.get("/models/#{id}/records/#{record_id}").parsed_response
      rescue MultiJson::DecodeError
      end

      BettyResource::Record.new(self, attributes) if attributes
    end

    def new(attributes = {})
      BettyResource::Record.new(self, attributes)
    end

    def to_s
      name
    end

    def self.parse(input)
      input.inject({}) do |hash, row|
        hash.merge(row["name"] => Model.new(row["id"], row["name"], Property.parse(row["properties"])))
      end
    end

  end
end
