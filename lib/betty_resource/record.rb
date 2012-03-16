module BettyResource
  class Record
    attr_reader :model

    def initialize(args)
      @model = args[:model]
      model.properties.each do |property|
        define_singleton_method("#{property.name}=") do |val|
          attributes[property.name] = val
        end
      end
    end

    def attributes
      @attributes ||= model.properties.inject(HashWithIndifferentAccess.new()) do |hash, property|
        hash.merge(property.name => nil)
      end
    end
  end
end
