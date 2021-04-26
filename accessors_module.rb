module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      attr_name = "@#{name}".to_s
      define_method(name) { instance_variable_get(attr_name) }
      define_method "#{attr_name}_history" do
        instance_variable_get("@#{attr_name}_history") || [nil]
      end

      define_method "#{attr_name}=" do |new_value|
        v = instance_variable_get("@#{attr_name}_history")
        v ||= [nil]
        v << new_value

        instance_variable_set("@#{attr_name}_history", v)
        instance_variable_set("@#{attr_name}", new_value)
      end
    end
  end

  def strong_attr_accessor(*names, type)
    names.each do |name|
      attr_name = "@#{name}".to_s
      define_method(name) { instance_variable_get(attr_name) }
      define_method("#{name}=".to_sym) { |value| raise TypeError unless value.instance_of?(type) }
    end
  end

end

class Test
  extend Accessors
  attr_accessor_with_history :ab, :bc
  strong_attr_accessor :a, :b, String
end