module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instance
    end

    def counter
      @instance += 1
    end
  end

  module InstanceMethods
    private

    def register_instances
      self.class.counter
    end
  end
end
