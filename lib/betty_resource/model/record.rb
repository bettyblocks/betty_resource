module BettyResource
  class Model < Base
    class Record < Base

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
        super()
        self.attributes = Hash[model.attributes.collect{|x| [x, nil]}].merge attributes
      end

      def new_record?
        @id.nil?
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

    end
  end
end