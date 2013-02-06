require_relative "../test_helper"

module Unit
  class TestConfiguration < MiniTest::Unit::TestCase

    describe BettyResource::Configuration do
      it "should be able to validate itself" do
        config = BettyResource::Configuration.new
        assert_raises(BettyResource::Configuration::InvalidError) do
          config.validate!
        end

        config.host = "localhost"
        assert_raises(BettyResource::Configuration::InvalidError) do
          config.validate!
        end

        config.host = "localhost"
        config.user = "foo"
        config.password = "bar"
        assert_nil config.validate!
      end
    end

  end
end