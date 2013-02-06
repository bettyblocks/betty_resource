require "betty_resource/model/property/types"

module BettyResource
  class Model
    class Property
      attr_reader :id, :name, :type

      def self.parse(data)
        new.tap do |property|
          property.instance_variable_set :@id, data["id"]
          property.instance_variable_set :@name, data["name"]
          property.instance_variable_set :@type, data["kind"]
        end
      end

    end
  end
end