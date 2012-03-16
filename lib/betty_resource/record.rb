module BettyResource
  class Record
    attr_reader :model

    def initialize(args)
      @model = args[:model]
    end
  end
end
