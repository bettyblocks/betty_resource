require "singleton"

module BettyResource
  class Configuration
    def initialize(args = {})
      args.each do |key, value|
        self.send("#{key}=", value) if [:host, :user, :password].include?(key.to_sym)
      end
    end

    class InvalidError < StandardError; end

    attr_accessor :host, :user, :password

    def validate!
      raise InvalidError if [:host, :user, :password].any?{|option| send(option).to_s.strip.empty?}
    end

  end
end