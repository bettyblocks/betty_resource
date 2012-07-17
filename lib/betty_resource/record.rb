module BettyResource
  class Record < Base
    attr_reader :id, :model

    def initialize(model, attributes = {})
      @id = attributes.delete(:id) || attributes.delete("id")
      @model = model
      define_accessors

      attributes.each do |key, value|
        send "#{key}=", value
      end
    end

    def save
      if new_record?
        result = self.class.post("/models/#{model.id}/records/new", to_params)
        @id = result.parsed_response["id"].to_i if result.code == 201
      else
        result = self.class.put("/models/#{model.id}/records/#{id}", to_params)
      end

      result.code.to_s[0..1] == "20" # success status codes starts with 20x
    end

    def attributes
      @attributes ||= model.properties.inject(HashWithIndifferentAccess.new) do |hash, property|
        hash.merge(property.name => nil)
      end
    end

    def new_record?
      @id.nil?
    end

    def as_json
      attributes.merge "id" => id
    end

  private

    def to_params
      {:body => {:record => attributes }}
    end

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