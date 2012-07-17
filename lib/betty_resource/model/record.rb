module BettyResource
  class Model < Base
    class Record < Base
      attr_reader :id, :model

      alias :_class :class
      def class
        model
      end

      def initialize(model, attributes = {})
        @id = attributes.delete(:id) || attributes.delete("id")
        @model = model
        define_accessors
        self.attributes = attributes
      end

      def new_record?
        @id.nil?
      end

      def attributes
        @attributes ||= model.properties.inject(HashWithIndifferentAccess.new) do |hash, property|
          hash.merge(property.name => nil)
        end
      end

      def attributes=(values)
        values.each do |key, value|
          send "#{key}=", value
        end
      end

      def save
        result = begin
          if new_record?
            Record.post("/models/#{model.id}/records/new", to_params)
          else
            Record.put("/models/#{model.id}/records/#{id}", to_params)
          end
        end
        (result.code.to_s[0..1] == "20").tap do |success|
          if success
            model.send :load, result.parsed_response, self
          end
        end
      end

      def as_json
        attributes.merge "id" => id
      end

    private

      def to_params
        {:body => {:record => attributes}}
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
end