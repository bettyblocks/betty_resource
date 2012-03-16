require "active_support/dependencies/autoload"
require "httparty"

module BettyResource
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Configuration

  def self.const_missing(name)
    puts "missing: #{name}"
  end

  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield config
  end
end
