module BettyResource
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Configuration

  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield config
  end
end
