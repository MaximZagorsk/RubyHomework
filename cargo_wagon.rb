class CargoWagon < Wagon
  def initialize
    super
    @type = init_type
  end

  private

  # Инициализация типа не должна быть доступна извне
  def init_type
    'cargo'
  end
end
