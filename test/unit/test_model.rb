require_relative '../test_helper'

module Unit
  class TestModel < MiniTest::Test

    describe BettyResource::Model do
      it 'should know its properties' do
        assert BettyResource::Relation.properties.is_a?(Array)
        assert BettyResource::Relation.properties.any?
        assert BettyResource::Relation.properties[0].is_a?(BettyResource::Model::Property)
      end

      it 'should know its attributes' do
        assert_equal %w(first_name group id last_name), BettyResource::Relation.attributes.sort
      end

      it 'should return a new record instance' do
        assert BettyResource::Relation.new.is_a?(BettyResource::Model::Record)
      end

      it 'should not load unexisting records' do
        assert_nil BettyResource::Relation.get(-1)
      end

      it 'should fetch a record' do
        relation = BettyResource::Relation.get(1)
        assert_equal 1, relation.id
        assert_equal 'Daniel', relation.first_name
        assert_equal 'Willemse', relation.last_name
      end

      it 'should fetch a first record' do
        relation = BettyResource::Relation.first
        assert_equal 1, relation.id
        assert_equal 'Daniel', relation.first_name
        assert_equal 'Willemse', relation.last_name

        relation = BettyResource::Relation.first filters: { path: BettyResource::Relation.property(:last_name).id, predicate: 'eq', criteria: 'Piet' }
        assert_nil relation

        relation = BettyResource::Relation.first filters: { path: BettyResource::Relation.property(:last_name).id, predicate: 'eq', criteria: 'Willemse' }
        assert_equal 1, relation.id
      end

      it 'should fetch multiple records' do
        relations = BettyResource::Relation.all
        assert_equal 100, relations.size
        assert relations.first.is_a?(BettyResource::Model::Record)

        relations = BettyResource::Relation.all limit: 10
        assert_equal 10, relations.size
        assert relations.first.is_a?(BettyResource::Model::Record)
      end

      it 'should directly create a record' do
        relation = BettyResource::Relation.create(first_name: 'Stephan', last_name: 'Kaag')
        assert relation
        assert relation.id > 0

        relation = BettyResource::Relation.get(relation.id)
        assert_equal 'Stephan', relation.first_name
        assert_equal 'Kaag', relation.last_name
      end
    end

  end
end
