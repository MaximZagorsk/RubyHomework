class PassengerTrain < Train
  def add_wagon(wagon)
    super if wagon.type == type
  end

  TYPE = 'passenger'
end
