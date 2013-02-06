module BettyResource
  class Model
    class Property
      module Types
        module Abstract
          module Base

            def typecast_json(value)
              value
            end

            def typecast(value)
              value
            end

            def format_json(value)
              value
            end

          end
        end
      end
    end
  end
end