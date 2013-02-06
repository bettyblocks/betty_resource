require "betty_resource/model/property"
require "betty_resource/model/record"

module BettyResource
  class Model
    attr_reader :id, :name, :properties

    def self.parse(data)
      new.tap do |model|
        model.instance_variable_set :@id, data["id"]
        model.instance_variable_set :@name, data["name"]
        model.instance_variable_set :@properties, data["properties"].collect{|d| Property.parse(d)}
      end
    end

    def attributes
      properties.collect(&:name)
    end

    def properties_map
      @properties_map ||= properties.inject({}) do |map, property|
        map[property.name] = BettyResource::Model::Property::Types.const_get camelize(property.type) unless property.name == "id"
        map
      end
    end

    def new(attributes = {})
      BettyResource::Model::Record.new(self, attributes)
    end

    def get(id)
      load Api.get("/models/#{self.id}/records/#{id}").parsed_response
    end

    def all(options = {})
      Api.get("/models/#{id}/records", :body => options).parsed_response.collect{|data| load data}
    end

    def create(attributes = {})
      new(attributes).tap do |record|
        record.save
      end
    end

    def inspect
      "BettyResource::#{name}"
    end
    alias :to_s :inspect

  private

    def camelize(word)
      word.split(/[^a-z0-9]/i).collect{|x| x.capitalize}.join
    end

    def load(data, record = nil)
      if data
        id = data.delete "id"
        (record || BettyResource::Model::Record.new(self)).tap do |record|
          record.instance_variable_set :@id, id
          record.send(:state).instance_variable_set :@raw_attributes, data
        end
      end
    end

  end
end