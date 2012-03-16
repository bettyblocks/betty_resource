module BettyResource
  class Record
    attr_reader :model

    def initialize(args)
      @model = args[:model]
    end

    def attributes
      @attributes ||= model.properties.inject(HashWithIndifferentAccess.new()) do |hash, property|
        hash.merge(property.name => nil)
      end
    end
  end
end
