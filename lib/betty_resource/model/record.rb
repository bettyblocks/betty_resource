require "betty_resource/model/record/state"

module BettyResource
  class Model
    class Record
      attr_reader :id

      def self.model
        @model
      end

      def self.attributes
        @attributes ||= model.properties.collect(&:name)
      end

      def self.properties_map
        @properties_map ||= model.properties.inject({}) do |map, property|
          map[property.name] = BettyResource::Model::Property::Types.const_get camelize(property.type) unless property.name == "id"
          map
        end
      end

      def self.all(options = {})
        Api.get("/models/#{model.id}/records", :body => options).parsed_response.collect{|data| load data}
      end

      def self.create(attributes = {})
        new(attributes).tap do |record|
          record.save
        end
      end

      def self.get(id)
        load Api.get("/models/#{model.id}/records/#{id}").parsed_response
      end

      def self.name
        "BettyResource::#{model.name}"
      end

      def initialize(attributes = {})
        send :attributes=, attributes
      end

      def model
        self.class.model
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
            self.class.send :load, parsed_response, self
          else
            msg = "Er is iets mis gegaan met het verwerken van het formulier. Probeer u het later nog eens. Onze excuses voor het ongemak"
            state.errors = parsed_response ? parsed_response["errors"] : {"" => [msg]}
          end
        end
      end

      def as_json
        {"id" => id}.merge state.as_json
      end

      def inspect
        "#<#{self.class.name} @id=#{id.inspect}#{state.inspect}>"
      end
      alias :to_s :inspect

    private

      def self.camelize(word)
        word.split(/[^a-z0-9]/i).collect{|x| x.capitalize}.join
      end

      def self.load(data, record = nil)
        if data
          id = data.delete "id"
          (record || new).tap do |record|
            record.instance_variable_set :@id, id
            record.send(:state).instance_variable_set :@raw_attributes, data
          end
        end
      end

      def state
        @state ||= State.new self.class
      end

    end
  end
end