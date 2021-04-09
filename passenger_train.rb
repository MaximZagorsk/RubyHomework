class PassengerTrain < Train
  def initialize(number)
    super
    @type = init_type
  end

  def add_wagon(wagon)
    super if wagon.type == type
  end

  private

  # Инициализация типа не должна быть доступна извне
  def init_type
    'passenger'
  end
end
