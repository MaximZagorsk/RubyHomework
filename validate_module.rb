module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def validate(name, type, arg = nil)
      hash_validations ||= {}
      hash_validations[:var] = name
      hash_validations[:type] = type
      hash_validations[:arg] = arg
      @validation_list ||= []
      @validation_list.push(hash_validations)
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get("@validation_list").each do |value|
        send("validate_#{value[:type]}", *[value[:var], value[:arg]])
      end
    end

    def validate_presence(name, arg)
      value = instance_variable_get("@#{name}")
      raise "#{name} can't be nil" if value.nil?
    end

    def validate_type(name, type)
      value = instance_variable_get("@#{name}")
      raise "Wrong type: #{name}" unless value.instance_of?(type)
    end

    def validate_format(name, format)
      value = instance_variable_get("@#{name}")
      raise "#{name} has invalid format" if value !~ format
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
  validate :type, :presence
  validate :type, :type, String

  def initialize(type)
    @type = type
    validate!
  end

end


