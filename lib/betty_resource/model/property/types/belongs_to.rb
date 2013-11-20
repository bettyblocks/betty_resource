module BettyResource
  class Model
    class Property
      module Types
        module BelongsTo
          include Association

          def typecast(record, value)
            if id = (value && value['id'])
              target_model.get(id)
            end
          end

        end
      end
    end
  end
end