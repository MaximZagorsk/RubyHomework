class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
  end

  def add_wagon(wagon)
    super if wagon.type == type
  end
end
