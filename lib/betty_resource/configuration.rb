require "singleton"

module BettyResource
  class Configuration
    class InvalidError < StandardError; end

    attr_accessor :host, :user, :password

    def validate!
      raise InvalidError if [:host, :user, :password].any?{|option| send(option).to_s.strip.empty?}
    end

  end
end