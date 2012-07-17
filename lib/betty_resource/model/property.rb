module BettyResource
  class Model < Base
    class Property
      attr_accessor :id, :name, :kind

      def self.parse(input)
        input.collect do |row|
          Property.new(row["id"], row["name"], row["kind"])
        end
      end

      def initialize(id, name, kind)
        @id, @name, @kind = id, name, kind
      end

    end
  end
end