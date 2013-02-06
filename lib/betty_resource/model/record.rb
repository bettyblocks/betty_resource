require "betty_resource/model/record/state"

module BettyResource
  class Model
    class Record
      attr_reader :id, :model

      def initialize(model, attributes = {})
        @model = model
        send :attributes=, attributes
      end

      alias :_class :class
      def class
        model
      end

      def new_record?
        @id.nil?
      end

      def id=(value)
      end

      def attributes=(attrs)
        attrs.each do |name, value|
          state.write name, value
        end
      end

      def attributes
        state.attributes
      end

      def changes
        state.changes
      end

      def errors
        state.errors.dup
      end

      def save
        state.errors.clear

        response = begin
          if new_record?
            Api.post("/models/#{model.id}/records/new", {:body => {:record => as_json}})
          else
            Api.put("/models/#{model.id}/records/#{id}", {:body => {:record => as_json}})
          end
        end

        parsed_response = response.parsed_response

        (response.code.to_s[0..1] == "20").tap do |success|
          if success
            model.send :load, parsed_response, self
          else
            msg = "Er is iets mis gegaan met het verwerken van het formulier. Probeer u het later nog eens. Onze excuses voor het ongemak"
            state.errors = parsed_response ? parsed_response["errors"] : {"" => [msg]}
          end
        end
      end

      def as_json
        {"id" => id}.merge state.as_json
      end

      def method_missing(method, *args)
        begin
          m = method.to_s
          if m.match(/=$/)
            state.write m.gsub(/=$/, ""), *args
          else
            state.read m
          end
        rescue State::InvalidNameError => e
          super
        end
      end

      def inspect
        "#<#{model.name} @id=#{id.inspect}#{state.inspect}>"
      end
      alias :to_s :inspect

    private

      def state
        @state ||= State.new model
      end

    end
  end
end