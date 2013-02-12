require "betty_resource/configuration"
require "betty_resource/api"
require "betty_resource/meta_data"
require "betty_resource/model"
require "betty_resource/version"

module BettyResource

  def self.configure(configuration = nil)
    config(false).tap do |config|
      if configuration
        config.assign configuration
      else
        yield config
      end
      config.validate!
      config.commit!
    end
  end

  def self.config(validate = true)
    (@configuration ||= Configuration.new).tap do |config|
      config.validate! if validate
    end
  end

  def self.meta_data
    @meta_data ||= MetaData.new
  end

  def self.const_missing(name)
    if m = meta_data.models[name.to_s]
      const_set name, m.record_class
    else
      super
    end
  end

end