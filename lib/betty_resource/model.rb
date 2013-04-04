module BettyResource
  class Model
    autoload :Record, "betty_resource/model/record"
    autoload :Property, "betty_resource/model/property"

    attr_accessor :id, :name, :properties

    def self.parse(input)
      input.inject({}) do |hash, row|
        hash.merge(row["name"] => Model.new(row["id"], row["name"], Property.parse(row["properties"])))
      end
    end

    def initialize(id, name, properties = [])
      @id, @name, @properties = id, name, properties
    end

    def property(name)
      properties.detect{|p|p.name == name.to_s}
    end

    def attributes
      properties.collect(&:name)
    end

    # TODO: Refactor this method in order to handle formatted view JSON correctly
    def all(options = {})
      begin
        response = Api.get("/models/#{id}/records", :body => options).parsed_response
        ((view_id = options.delete(:view_id) || options.delete("view_id")).nil? ? response : response["records"]).collect do |data|
          load data
        end
      rescue MultiJson::DecodeError
      end
    end

    def get(record_id)
      begin
        load Api.get("/models/#{id}/records/#{record_id}").parsed_response
      rescue MultiJson::DecodeError
      end
    end

    def first(options = {})
      all(options.merge(:limit => 1)).first
    end

    def new(attributes = {})
      BettyResource::Model::Record.new(self, attributes)
    end

    def create(attributes = {})
      new(attributes).tap do |record|
        record.save
      end
    end

    def to_s
      name
    end

  private

    def load(data, record = nil)
      if data
        id = data.delete "id"
        (record || BettyResource::Model::Record.new(self)).tap do |record|
          record.instance_variable_set :@id, id
          record.attributes = data
          record.clean_up!
        end
      end
    end

  end
end