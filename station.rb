class Station
  @@object = []
  attr_reader :name, :trains

  class << self
    def all
      @@object
    end
  end

  # При инициализации класса определяется его имя
  def initialize(name)
    @name = name
    # Пустой список колличества поездов на станции
    @trains = []
    @@object << self
  end


  # Прием поезда
  def get_train(train)
    @trains.push(train)
  end

  # Возвращение списка поездов на станции по типу
  def get_trains_by_type(type)
    @trains.select { |item| item.type == type }
  end

  # Удаление поезда со станции
  def send_train(train)
    @trains.delete(train)
  end
end
