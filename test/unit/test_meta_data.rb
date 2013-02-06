require_relative "../test_helper"

module Unit
  class TestMetaData < MiniTest::Unit::TestCase

    describe BettyResource::MetaData do
      it "should be able to fetch models" do
        meta_data = BettyResource::MetaData.new
        assert_equal true, meta_data.models.is_a?(Hash)
        assert_equal true, meta_data.models.include?("Relation")
      end
    end

  end
end