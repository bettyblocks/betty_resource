module BettyResource
  class Model
    class Property
      module Types
        module HasMany
          include Association

          def collection?
            true
          end

          def typecast(record, value)
            filter = {
              'operator' => 'and',
              'conditions' => [
                'path' => [inverse_property.id, model.property(:id).id],
                'predicate' => 'eq',
                'criteria' => record.id
              ]
            }

            target_model.all :filters => [filter]
          end

        end
      end
    end
  end
end