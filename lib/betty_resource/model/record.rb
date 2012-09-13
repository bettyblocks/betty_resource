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
      end

      # TODO: Test this
      def new_record?
        @id.nil?
      end

      # TODO: Test this
      def changed?
        attributes.changed?
      end

      # TODO: Test this
      def dirty?
        new_record? || changed?
      end

      def valid?
        !@errors.any?
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
        # TODO: Test this
        return true unless dirty?

        result = begin
          if new_record?
            Api.post("/models/#{model.id}/records/new", to_params)
          else
            Api.put("/models/#{model.id}/records/#{id}", to_params)
          end
        end

        (result.code.to_s[0..1] == "20").tap do |success|
          if success
            @errors.clear
            model.send :load, result.parsed_response, self
          else
            @errors = result.parsed_response["errors"]
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

      # TODO: Clean this up as this is a dirty quick fix for loading belongs_to properties at the moment
      def method_missing(method, *args)
        if method.to_s.match(/^(\w+).id=$/)
          if model.attributes.include?($1)
            instance = attributes[$1] ||= begin
              if property = model.properties.detect{|x| x.name == $1}
                property.model.new
              end
            end
            if instance
              return instance.instance_variable_set :@id, args.first
            end
          end
        end
        super
      end

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
