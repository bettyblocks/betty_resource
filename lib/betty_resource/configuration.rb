require "singleton"

module BettyResource
  class Configuration
    class InvalidError < StandardError; end

    attr_accessor :host, :user, :password

    def initialize(config = {})
      assign config
    end

    def assign(config)
      config.each do |key, value|
        self.send("#{key}=", value) if [:host, :user, :password].include?(key.to_sym)
      end
    end

    def validate!
      raise InvalidError if [:host, :user, :password].any?{|option| send(option).to_s.strip.empty?}
    end

    def commit!
      Api.base_uri   "#{host}/api"
      Api.basic_auth user, password
    end

  end
end