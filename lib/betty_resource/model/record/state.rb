module BettyResource
  class Model
    class Record
      class State

        class InvalidNameError < StandardError; end

        attr_reader :raw_attributes, :attributes, :variables, :changes, :errors

        def initialize(record_class)
          @record_class = record_class
          @raw_attributes = {}
          @attributes = {}
          @variables = {}
          @changes = {}
          @errors = {}
        end

        def read(name)
          assert_valid_name!(name = name.to_s)

          unless attributes.include?(name)
            attributes[name] = @record_class.properties_map[name].typecast_json(raw_attributes[name])
            raw_attributes.delete name
          end

          attributes[name]
        end

        def write(name, value)
          assert_valid_name!(name = name.to_s)
          attributes[name] = @record_class.properties_map[name].typecast(value)
          value
        end

        def errors=(errors)
          @errors.replace errors
        end

        def as_json(options = {})
          @record_class.properties_map.inject({}) do |json, (name, type)|
            json[name] = type.format_json read(name)
            json
          end
        end

        def inspect
          @record_class.properties_map.collect{|name, type| " @#{name}=#{inspect_value(name)}"}.join
        end

      private

        def assert_valid_name!(name)
          raise InvalidNameError, "Invalid name '#{name}' for #{@record_class.name}" unless @record_class.properties_map.keys.include?(name)
        end

        def inspect_value(name)
          if attributes.include?(name)
            value = attributes[name].inspect
            if value.size > 40
              "#{value[0, 40].strip}...>"
            else
              value
            end
          else
            "<not loaded>"
          end
        end

      end
    end
  end
end