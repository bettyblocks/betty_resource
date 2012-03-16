module BettyResource
  class Record
    attr_reader :id
    attr_reader :model

    def initialize(model, attributes = {})
      @id = attributes.delete(:id) || attributes.delete("id")
      @model = model
      define_accessors

      attributes.each do |key, value|
        send "#{key}=", value
      end
    end

    def attributes
      @attributes ||= model.properties.inject(HashWithIndifferentAccess.new) do |hash, property|
        hash.merge(property.name => nil)
      end
    end

  private
    def define_accessors
      model.properties.reject{|p|p.name == "id"}.each do |property|
        define_setter(property)
        define_getter(property)
      end
    end

    def define_setter(property)
      define_singleton_method("#{property.name}=") do |val|
        attributes[property.name] = val
      end
    end

    def define_getter(property)
      define_singleton_method("#{property.name}") do
        attributes[property.name]
      end
    end
  end
end
