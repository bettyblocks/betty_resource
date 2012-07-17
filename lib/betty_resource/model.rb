module BettyResource
  class Model < Base
    extend ActiveSupport::Autoload

    autoload :Record
    autoload :Property

    attr_accessor :id, :name, :properties

    def self.parse(input)
      input.inject({}) do |hash, row|
        hash.merge(row["name"] => Model.new(row["id"], row["name"], Property.parse(row["properties"])))
      end
    end

    def initialize(id, name, properties = [])
      @id, @name, @properties = id, name, properties
    end

    def attributes
      properties.collect(&:name)
    end

    def all(options = {})
      begin
        self.class.get("/models/#{id}/records", :body => options).parsed_response.collect do |data|
          load data
        end
      rescue MultiJson::DecodeError
      end
    end

    def get(record_id)
      begin
        load self.class.get("/models/#{id}/records/#{record_id}").parsed_response
      rescue MultiJson::DecodeError
      end
    end

    def new(attributes = {})
      BettyResource::Model::Record.new(self, attributes)
    end

    def create(attributes = {})
      new(attributes).tap do |record|
        record.save
      end
    end

    def to_s
      name
    end

  private

    def load(data, record = nil)
      if data
        id = data.delete "id"
        (record || BettyResource::Model::Record.new(self)).tap do |record|
          record.instance_variable_set :@id, id
          record.attributes = data
        end
      end
    end

  end
end