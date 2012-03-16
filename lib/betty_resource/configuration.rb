require 'singleton'

module BettyResource
  class Configuration

    @@defaults = {
    }

    def initialize
      @@defaults.each_pair{|k,v| self.send("#{k}=",v)}
    end

    attr_accessor :host, :user, :password

    def validate!
      raise InvalidConfigurationError if [:host, :user, :password].any?{|option|send(option).blank?}
    end

    class InvalidConfigurationError < ::StandardError
    end
  end
end
