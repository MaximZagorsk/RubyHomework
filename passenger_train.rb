

require_relative 'train'

class PassengerTrain < Train
  validate :number, :validate_presence
  validate :number, :validate_format, NUMBER_FORMAT

  def initialize(number)
    super
    @type = 'passenger'
  end
end
