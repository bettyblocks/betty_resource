require_relative '../test_helper'

module Unit
  class TestBase < MiniTest::Unit::TestCase

    describe BettyResource do
      it 'should validate its config' do
        assert config = BettyResource.config

        config.expects(:host).returns(nil)
        assert_raises(BettyResource::Configuration::InvalidError) do
          BettyResource.config
        end

        config.expects(:host).returns('')
        assert_raises(BettyResource::Configuration::InvalidError) do
          BettyResource.config
        end

        config.expects(:host).returns(' ')
        assert_raises(BettyResource::Configuration::InvalidError) do
          BettyResource.config
        end

        config.expects(:host).returns('localhost')
        assert BettyResource.config
      end

      it 'should return a model instance' do
        assert BettyResource::Relation.is_a?(BettyResource::Model)
      end

      it 'should raise NameError when an unknown model is requested' do
        assert_raises(NameError) do
          assert BettyResource::DoesNotExist
        end
      end
    end

  end
end
