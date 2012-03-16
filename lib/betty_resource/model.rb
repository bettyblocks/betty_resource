module BettyResource
  class Model < Base
    attr_accessor :id, :name, :properties

    def initialize(id, name, properties = [])
      # TODO: require id, name
      @id, @name, @properties = id, name, properties
    end

    def self.parse(input)
      input.inject({}) do |hash, row|
        hash.merge(row["name"] => Model.new(row["id"], row["name"], row["properties"]))
      end
    end
  end
end