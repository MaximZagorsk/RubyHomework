class CargoTrain < Train
  def add_wagon(wagon)
    super if wagon.type == type
  end

  TYPE = 'cargo'
end
