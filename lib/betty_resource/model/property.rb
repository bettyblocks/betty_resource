module BettyResource
  class Model
    class Property
      attr_accessor :id, :name, :kind, :options

      def self.parse(input)
        input.collect do |row|
          Property.new(row["id"], row["name"], row["kind"], row["options"])
        end
      end

      def initialize(id, name, kind, options)
        @id, @name, @kind, @options = id, name, kind, options
      end

      # TODO: Clean this up as this is a dirty quick fix for loading belongs_to properties at the moment
      def model
        BettyResource.meta_data.models.values.detect{|x| x.id == options["model"]} if kind == "belongs_to"
      end

    end
  end
end
