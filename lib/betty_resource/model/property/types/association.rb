module BettyResource
  class Model
    class Property
      module Types
        module Association

        private

          def target_model
            BettyResource.meta_data.models.values.find { |x| x.id == options['model'] }
          end

          def inverse_property
            @inverse_property ||= target_model.properties.find { |x| x.id == options['inverse_association'] }
          end

        end
      end
    end
  end
end