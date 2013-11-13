module BettyResource
  class Model
    class Property
      attr_accessor :id, :name, :kind, :options

      def self.parse(input)
        input.map do |row|
          Property.new(row['id'], row['name'], row['kind'], row['options'])
        end
      end

      def initialize(id, name, kind, options)
        @id, @name, @kind, @options = id, name, kind, options
      end

      def typecast(value)
        if kind == 'belongs_to' && id = (value && value['id'])
          model.get(id)
        else
          value
        end
      end

      def model
        BettyResource.meta_data.models.values.find { |x| x.id == options['model'] } if kind == 'belongs_to'
      end

    end
  end
end
