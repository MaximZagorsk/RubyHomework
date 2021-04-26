# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, value, arg = nil)
      @all ||= []
      @all << "#{name}_validate"
      define_method("#{name}_validate") do
        case value
        when :presence
          presence = instance_variable_get("@#{name}")
          raise "#{name} can't be nil" if presence.nil?
        when :format
          format = instance_variable_get("@#{name}")
          raise "#{name} has invalid format" if format !~ arg
        when :type
          type = instance_variable_get("@#{name}")
          raise "Wrong type: #{name}" unless type.instance_of?(arg)
        end
      end
    end

    def value
      @all
    end
  end

  module InstanceMethods
    def validate!
      self.class.value.each do |value|
        send(value)
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end
