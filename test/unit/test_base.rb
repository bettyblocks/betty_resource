require_relative "../test_helper"

module Unit
  class TestBase < MiniTest::Unit::TestCase

    describe BettyResource::Base do
      it "should return a model instance" do
        assert BettyResource::Relation.is_a?(BettyResource::Model)
      end

      it "should raise NameError when an unknown model is requested" do
        assert_raises(NameError) do
          assert BettyResource::DoesNotExist
        end
      end
    end

  end
end