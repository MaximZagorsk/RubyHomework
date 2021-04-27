
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(*args)
      instance_variable_set("@validation_#{args[0]}_#{args[1]}", args)
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variables.each do |value|
        arg = self.class.instance_variable_get("#{value}")
        if value.to_s.start_with?("@validation")
          send(arg[1], arg)
        end
      end
    end

    def validate_presence(args)
      presence = instance_variable_get("@#{args[0]}")
      raise "#{args[0]} can't be nil" if presence.nil?
    end

    def validate_type(args)
      value = instance_variable_get("@#{args[0]}")
      raise "Wrong type: #{args[0]}" unless value.instance_of?(args[2])
    end

    def validate_format(args)
      value = instance_variable_get("@#{args[0]}")
      raise "#{args[0]} has invalid format" if value !~ args[2]
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end

class Test
  include ::Validation
  validate :type, :validate_presence
  validate :type, :validate_type, String

  def initialize(type)
    @type = type
  end

end


