module BettyResource
  class Model < Base
    extend ActiveSupport::Autoload

    autoload :Record
    autoload :Property

    attr_accessor :id, :name, :properties

    def initialize(id, name, properties = [])
      # TODO: require id, name
      @id, @name, @properties = id, name, properties
    end

    def self.parse(input)
      input.inject({}) do |hash, row|
        hash.merge(row["name"] => Model.new(row["id"], row["name"], Property.parse(row["properties"])))
      end
    end

    def all(options = {})
      self.class.post("/models/#{id}/records", :query => options).parsed_response.collect do |json|
        attributes = begin
          json
        rescue MultiJson::DecodeError
        end
        BettyResource::Model::Record.new(self, json) if attributes
      end
    end

    def get(record_id)
      attributes = begin
        self.class.get("/models/#{id}/records/#{record_id}").parsed_response
      rescue MultiJson::DecodeError
      end

      BettyResource::Model::Record.new(self, attributes) if attributes
    end

    def new(attributes = {})
      BettyResource::Model::Record.new(self, attributes)
    end

    def create(attributes = {})
      record = new(attributes)
      record.save
      record
    end

    def to_s
      name
    end

  end
end