require 'betty_resource/model/property/types/association'
require 'betty_resource/model/property/types/belongs_to'
require 'betty_resource/model/property/types/has_many'

module BettyResource
  class Model
    class Property
      include KindExtendable
      attr_reader :id, :name, :kind, :options

      def self.parse(model_id, input)
        input.map do |row|
          options = row['options']
          inverse_association = row["inverse_association"]
          options.merge!("inverse_association" => inverse_association) if inverse_association
          Property.new(row['id'], model_id, row['name'], row['kind'], options)
        end
      end

      def initialize(id, model_id, name, kind, options)
        @id, @model_id, @name, @kind, @options = id, model_id, name, kind, options
        extend_kind_methods if %(belongs_to has_many).include?(kind)
      end

      def collection?
        false
      end

      def typecast(record, value)
        value
      end

      def model
        @model ||= BettyResource.meta_data.models.values.find { |x| x.id == @model_id }
      end

    end
  end
end
