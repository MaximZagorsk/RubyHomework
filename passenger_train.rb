class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'passenger'
  end

  def add_wagon(wagon)
    super if wagon.type == type
  end
end
