require_relative "../test_helper"

module Unit
  class TestGem < MiniTest::Unit::TestCase

    describe BettyResource do
      it "should validate its configuration" do
        config = BettyResource.config

        config.expects(:host).returns(nil)
        assert_raises(BettyResource::Configuration::InvalidError) do
          BettyResource.config
        end

        config.expects(:host).returns("")
        assert_raises(BettyResource::Configuration::InvalidError) do
          BettyResource.config
        end

        config.expects(:host).returns(" ")
        assert_raises(BettyResource::Configuration::InvalidError) do
          BettyResource.config
        end

        config.expects(:host).returns("localhost")
        BettyResource.config
      end

      it "should return a model instance" do
        assert_equal true, BettyResource::Relation.is_a?(Class)
        assert_equal true, BettyResource::Relation.new.is_a?(BettyResource::Model::Record)
      end

      it "should raise NameError when an unknown model is requested" do
        assert_raises(NameError) do
          BettyResource::DoesNotExist
        end
      end
    end

  end
end