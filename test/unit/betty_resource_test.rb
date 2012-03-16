require_relative '../test_helper'

module Unit
  class BettyResourceTest < MiniTest::Unit::TestCase

    describe BettyResource::Base do
      it "should return a Relation model" do
        assert BettyResource::Relation.is_a?(BettyResource::Model)
      end

      it "should return a new Relation object" do
        assert BettyResource::Relation.new.is_a?(BettyResource::Record)
      end

      it "should return the model of a BettyResource::Record" do
        assert_equal BettyResource::Relation.new.model, BettyResource::Relation
      end

      it "should raise NameError when an unknown model is requested" do
        assert_raises(NameError) {
          assert BettyResource::DoesNotExist
        }
      end
    end
  end
end
