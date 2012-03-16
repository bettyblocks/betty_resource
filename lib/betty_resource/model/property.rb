module BettyResource
  class Model < Base
    class Property
      attr_accessor :id, :name, :kind

      def initialize(id, name, kind)
        # TODO: require id, name, kind
        @id, @name, @properties = id, name, kind
      end
      
      def self.parse(input)
        input.collect do |row|
          Property.new(row["id"], row["name"], row["kind"])
        end
      end
    end
  end
end