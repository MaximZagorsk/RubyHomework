
class Wagon
  include ::Company
  attr_reader :type, :number

  def initialize(number, _value)
    @type = nil
    @number = number
  end
end
