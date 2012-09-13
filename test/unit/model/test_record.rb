require_relative "../../test_helper"

module Unit
  module Record
    class TestRecord < MiniTest::Unit::TestCase

      describe BettyResource::Model::Record do
        it "should return its model" do
          assert_equal BettyResource::Relation, BettyResource::Relation.new.model
          assert_equal BettyResource::Relation, BettyResource::Relation.new.class
        end

        it "should return its attributes" do
          relation = BettyResource::Relation.new
          assert_equal ["first_name", "last_name"], relation.attributes.keys.sort
        end

        it "should create a method for writing each attribute" do
          relation = BettyResource::Relation.new
          assert relation.first_name = "my_first_name"
          assert relation.last_name = "my_last_name"
        end

        it "should create a method for reading each attribute" do
          relation = BettyResource::Relation.new
          relation.first_name = "my_first_name"
          assert_equal "my_first_name", relation.first_name
        end

        it "should store its values in the @attributes instance variable" do
          relation = BettyResource::Relation.new
          relation.first_name = "my_first_name"
          assert_equal "my_first_name", relation.attributes[:first_name]
        end

        it "should allow mass-assignment when initializing" do
          relation = BettyResource::Relation.new(:first_name => "my_first_name", :last_name => "my_last_name")
          assert_equal "my_first_name", relation.first_name
          assert_equal "my_last_name", relation.last_name
        end

        it "should allow mass-assignment when already initialized" do
          relation = BettyResource::Relation.new
          relation.attributes = {:first_name => "my_first_name", :last_name => "my_last_name"}
          assert_equal "my_first_name", relation.first_name
          assert_equal "my_last_name", relation.last_name
        end

        it "should not allow setting of id" do
          relation = BettyResource::Relation.get(1)
          assert_equal 1, relation.id
          assert_raises(NoMethodError) do
            assert relation.id = 2
          end
        end

        it "should be able to represent itself as JSON" do
          relation = BettyResource::Relation.new(:first_name => "Paul", :last_name => "Engel")
          assert_equal({"id" => nil, "first_name" => "Paul", "last_name" => "Engel"}, relation.as_json)

          relation = BettyResource::Relation.get(1)
          assert_equal({"id" => 1, "first_name" => "Daniel", "last_name" => "Willemse"}, relation.as_json)
        end

        it "should save itself" do
          relation = BettyResource::Relation.new(:first_name => "Stephan", :last_name => "Kaag")
          assert relation.save
          assert relation.id > 0

          relation = BettyResource::Relation.get(relation.id)
          assert_equal "Stephan", relation.first_name
          assert_equal "Kaag", relation.last_name
        end

        it "should not save itself when invalid (first_name is required)" do
          relation = BettyResource::Relation.new
          assert !relation.save
          assert_equal({"first_name"=>["moet ingevuld zijn"]}, relation.errors)

          relation.first_name = "Stephan"
          assert relation.save
        end

        it "should return invalid if there are errors" do
          relation = BettyResource::Relation.new
          relation.save

          assert_equal({"first_name"=>["moet ingevuld zijn"]}, relation.errors)

          assert !relation.valid?
        end

        it "should update errors after " do
          relation = BettyResource::Relation.new
          relation.save

          assert_equal({"first_name"=>["moet ingevuld zijn"]}, relation.errors)

          relation.first_name = "Bruce"
          relation.save

          assert_equal({}, relation.errors)
        end

        it "should have read-only errors messages" do
          relation = BettyResource::Relation.create
          assert_equal({"first_name"=>["moet ingevuld zijn"]}, relation.errors)

          relation.errors.clear
          assert_equal({"first_name"=>["moet ingevuld zijn"]}, relation.errors)
        end

        it "should not resave itself when invalid" do
          relation = BettyResource::Relation.new(:first_name => "Piet")
          assert relation.save

          relation.first_name = ""
          assert !relation.save
          assert relation.id > 0

          assert_equal "Piet", BettyResource::Relation.get(relation.id).first_name
        end

        it "should update itself" do
          relation = BettyResource::Relation.new(:first_name => "Stefan", :last_name => "Kaag")
          relation.save

          relation.first_name = "Stephan"
          relation.save

          relation = BettyResource::Relation.get(relation.id)
          assert_equal "Stephan", relation.first_name
        end
      end

    end
  end
end
