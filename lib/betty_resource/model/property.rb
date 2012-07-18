module BettyResource
  class Model < Base
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

    end
  end
end