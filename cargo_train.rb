

require_relative 'train'

class CargoTrain < Train
  validate :number, :validate_presence
  validate :number, :validate_format, NUMBER_FORMAT
  def initialize(number)
    super
    @type = 'cargo'
  end
end
