require "active_support/dependencies/autoload"
require "httparty"
require "crack/json"
require "dirty_hashy"

module BettyResource
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Configuration
  autoload :MetaData
  autoload :Model

  def self.const_missing(name)
    meta_data.model(name).tap do |model|
       const_set(name, model)
    end || super
  end

  def self.meta_data
    @meta_data ||= MetaData.new
  end

  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield config
  end

end