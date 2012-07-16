require_relative '../test_helper'

module Unit
  class BettyResourceModelTest < MiniTest::Unit::TestCase

    describe BettyResource::Model do
      describe "Properties" do
        it "should know properties" do
          assert BettyResource::Relation.properties.is_a?(Array)
          assert BettyResource::Relation.properties.any?
          assert BettyResource::Relation.properties[0].is_a?(BettyResource::Model::Property)
        end
      end

      describe "Fetching" do
        it "should be able to get a record" do
          relation = BettyResource::Relation.get(1)
          assert relation.is_a?(BettyResource::Record)
        end
      end
    end

  end
end