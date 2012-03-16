require_relative '../test_helper'

module Unit
  class BettyResourceTest < MiniTest::Unit::TestCase

    describe BettyResource::Base do
      it "should work" do
        assert BettyResource::Relation
      end

      it "should raise NameError when an unknown model is requested" do
        assert_raises(NameError) {
          assert BettyResource::DoesNotExist
        }
      end
    end
    
  end
end