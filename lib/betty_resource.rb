require "active_support/dependencies/autoload"
require "active_support/hash_with_indifferent_access"
require "httparty"
require "crack/json"

module BettyResource
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Configuration
  autoload :MetaData
  autoload :Model
  autoload :Record

  def self.const_missing(name)
    meta_data.model(name).tap do |model|
       const_set(name, model)
    end || super
  end

  def self.config
    @configuration ||= Configuration.new
  end

  def self.meta_data
    @meta_data ||= MetaData.new
  end

  def self.configure
    yield config
  end

end