require "active_support/dependencies/autoload"
require "active_support/core_ext/hash/indifferent_access" # See https://gist.github.com/1075643

require "httparty"
require "crack/json"
require "dirty_hashy"

module BettyResource
  extend ActiveSupport::Autoload

  autoload :Api
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

  def self.config(validate = true)
    (@configuration ||= Configuration.new).tap do |config|
      config.validate! if validate
    end
  end

  def self.configure
    yield config(false)
  end

end