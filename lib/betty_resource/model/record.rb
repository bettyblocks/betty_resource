class DirtyHashy < HashWithIndifferentAccess

  alias_method :regular_reader, :[]
  def [](key, mapped = false)
    typecasted(key) || set_typecasted(key, regular_reader(key, mapped))
  end

  protected

  def typecasted(key)
    instance_variable_get("@typecasted_#{key}")
  end

  def set_typecasted(key, value)
    if @model
      @model.typecast(key, value)
    else
      value
    end
  end

end

module BettyResource
  class Model
    class Record

      include DirtyAttributes::InstanceMethods
      include MethodMap
      attr_reader :id, :model

      alias :_class :class
      def class
        model
      end

      def initialize(model, attributes = {})
        @model = model
        @id = attributes.delete(:id) || attributes.delete("id")
        @errors = {}
        super()
        self.attributes = Hash[model.attributes.collect{|x| [x, nil]}].merge attributes
        self.attributes.instance_variable_set(:@model, model)
      end

      def new_record?
        @id.nil?
      end

      # TODO: Test this
      def attributes=(other)
        other.each do |key, value|
          send "#{key}=", value
        end
      end

      def errors
        @errors.dup
      end

      def save
        @errors.clear

        result = begin
          if new_record?
            Api.post("/models/#{model.id}/records/new", to_params)
          else
            Api.put("/models/#{model.id}/records/#{id}", to_params)
          end
        end

        result.success?.tap do |success|
          if success
            model.send :load, result.parsed_response, self
          else
            @errors = result.parsed_response ? result.parsed_response["errors"] : {"" => ["Er is iets mis gegaan met het verwerken van het formulier. Probeer u het later nog eens. Onze excuses voor het ongemak"]}
          end
        end
      end

      def inspect
        inspection = "id: #{id.inspect}, #{attributes.collect{|key, value| "#{key}: #{value.inspect}"}.join(", ")}"
        "#<#{model.name} #{inspection}>"
      end
      alias :to_s :inspect

      # TODO: Test this update
      def as_json(options = {})
        attributes_as_json(options).merge! "id" => id
      end

    private

      def to_params
        {:body => {:record => attributes_as_json}}
      end

      # TODO: Test this update
      def attributes_as_json(options = {})
        attributes.inject({}) do |h, (k, v)|
          h.merge! k => (v.respond_to?(:as_json) ? v.as_json(options) : v) if v
          h
        end
      end

    end
  end
end