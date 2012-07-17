module BettyResource
  class Model < Base
    extend ActiveSupport::Autoload

    autoload :Record
    autoload :Property

    attr_accessor :id, :name, :properties

    def initialize(id, name, properties = [])
      # TODO: require id, name
      @id, @name, @properties = id, name, properties
    end

    def self.parse(input)
      input.inject({}) do |hash, row|
        hash.merge(row["name"] => Model.new(row["id"], row["name"], Property.parse(row["properties"])))
      end
    end

    def all(options = {})
      load(self.class.get("/models/#{id}/records", :body => options))
    end

    def get(record_id)
      if data = load(self.class.get("/models/#{id}/records/#{record_id}"))
        data.first
      end
    end

    def new(attributes = {})
      BettyResource::Model::Record.new(self, attributes)
    end

    def create(attributes = {})
      record = new(attributes)
      record.save
      record
    end

    def to_s
      name
    end

  private

    def load(data)
      if parsed_data = data.parsed_response
        begin
          [parsed_data].flatten.collect do |data|
            if data
              id = data.delete "id"
              BettyResource::Model::Record.new(self, data).tap do |record|
                record.instance_variable_set :@id, id
              end
            end
          end
        rescue MultiJson::DecodeError
        end
      end
    end

  end
end