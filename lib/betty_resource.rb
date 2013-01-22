require "active_support/core_ext/hash/indifferent_access" # See https://gist.github.com/1075643

require "httparty"
require "crack/json"
require "dirty_hashy"

module BettyResource
  autoload :Api, "betty_resource/api"
  autoload :Configuration, "betty_resource/configuration"
  autoload :MetaData, "betty_resource/meta_data"
  autoload :Model, "betty_resource/model"

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

  def self.configure(configuration = nil)
    if configuration
      @configuration = Configuration.new(configuration).tap do |config|
        config.validate!
      end
    else
      yield config(false)
    end
  end

end