module BettyResource
  class Model
    class Property
      module Types

        def self.all
          %w(belongs_to boolean boolean_expression date date_expression date_time date_time_expression decimal) +
          %w(email enum file float has_and_belongs_to_many has_one has_many image integer integer_expression) +
          %w(liquid_expression minutes minutes_expression periodic_count periodic_minutes_sum pdf price price_expression) +
          %w(string string_expression text translation serial zipcode)
        end

      end
    end
  end
end

require "betty_resource/model/property/types/abstract/base"
require "betty_resource/model/property/types/abstract/readonly"

BettyResource::Model::Property::Types.all.each do |type|
  require "betty_resource/model/property/types/#{type}"
end