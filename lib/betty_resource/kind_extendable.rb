module KindExtendable

  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def extend_kind_methods
      unless (m = kind_module).nil?
        extend m
      end
    end

    def kind=(value)
      if defined?(super)
        super
      else
        @kind = value
      end
      @kind_module = nil
      extend_kind_methods
    end

    def kind_module
      @kind_module ||= begin
        if kind.is_a?(String) && !kind.empty?
          m = kind.gsub(/(?:^|_)(.)/) { Regexp.last_match[1].upcase }
          ActiveSupport::Inflector.constantize("#{self.class}::Types::#{m}")
        end
      end
    end
  end

end