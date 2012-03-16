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

      it "should return the attributes for a new BettyResource::Record" do
        relation = BettyResource::Relation.new
        assert_equal relation.attributes.keys.sort, ["first_name", "last_name"]
      end

      it "should create a method for writing each attribute" do
        relation = BettyResource::Relation.new
        assert relation.first_name = "my_first_name"
        assert relation.last_name = "my_last_name"
      end

      it "should store the value in @attributes variable" do
        relation = BettyResource::Relation.new
        relation.first_name = "my_first_name"
        assert_equal relation.attributes[:first_name], "my_first_name"
      end

      it "should create a method for reading each attribute" do
        relation = BettyResource::Relation.new
        relation.first_name = "my_first_name"
        assert_equal relation.first_name, "my_first_name"
      end

      it "should allow mass-assignment when creating a new record" do
        relation = BettyResource::Relation.new({:first_name => "my_first_name", :last_name => "my_last_name"})
        assert_equal relation.first_name, "my_first_name"
        assert_equal relation.last_name, "my_last_name"
      end

      it "should raise NameError when an unknown model is requested" do
        assert_raises(NameError) {
          assert BettyResource::DoesNotExist
        }
      end

      it "should not load unexising records" do
        assert_nil BettyResource::Relation.get(-1)
      end

      it "should load attributes" do
        relation = BettyResource::Relation.get(1)
        assert_equal "Daniel", relation.first_name
        assert_equal "Willemse", relation.last_name
        assert_equal 1, relation.id
      end

      it "should not allow setting of id" do
        relation = BettyResource::Relation.get(1)
        assert_equal 1, relation.id
        assert_raises(NoMethodError) {
          assert relation.id = 2
        }
      end

      it "should save a new record" do
        relation = BettyResource::Relation.new(:first_name => "Stephan", :last_name => "Kaag")
        relation.save

        assert relation.id > 0
      end

      it "should save an existing record" do
        relation = BettyResource::Relation.new(:first_name => "Stefan", :last_name => "Kaag")
        relation.save

        relation.first_name = "Stephan"
        relation.save

        final_relation = BettyResource::Relation.get(relation.id)
        assert_equal "Stephan", final_relation.first_name
      end
    end
  end
end
