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

    def record_class
      Class.new(Record).tap do |record_class|
        record_class.instance_variable_set :@model, self
        record_class.class_eval do
          @model.properties.each do |property|
            next if property.name == "id"
            define_method property.name do
              state.read property.name
            end
            define_method "#{property.name}=" do |value|
              state.write property.name, value
            end
          end
        end
      end
    end

  end
end