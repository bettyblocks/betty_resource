require 'singleton'

module BettyResource
  class Configuration
    attr_accessor :host, :user, :password

    def validate!
      raise InvalidConfigurationError if [:host, :user, :password].any?{|option|send(option).blank?}
    end

    class InvalidConfigurationError < ::StandardError
    end

  end
end