require_relative '../test_helper'

module Unit
  class BettyResourceTest < MiniTest::Unit::TestCase

    describe BettyResource::Base do
      it "should work" do
        assert BettyResource::Base
      end
    end
    
  end
end