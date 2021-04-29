

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instance ||= 0
    end

    def counter
      if @instance.nil?
        @instance = 0
        @instance += 1
      else
        @instance += 1
      end
    end
  end

  module InstanceMethods
    private

    def register_instances
      self.class.counter
    end
  end
end
