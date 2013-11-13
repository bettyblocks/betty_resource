module BettyResource
  class Model
    class Property
      module Types
        module HasMany
          include Association

          def collection?
            true
          end

          def typecast(value)
            filter = {
              'operator' => 'and',
              'conditions' => [
                'path' => [inverse_property.id, model.property(:id).id],
                'predicate' => 'eq',
                'criteria' => 1
              ]
            }

            target_model.all :filters => [filter]
          end

        end
      end
    end
  end
end