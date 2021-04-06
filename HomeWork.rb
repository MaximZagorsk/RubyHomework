
class Station
  attr_reader :name, :trains

  # При инициализации класса определяется его имя
  def initialize(name)
    @name = name
    # Пустой список колличества поездов на станции
    @trains = []
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
  def send_train
    @trains.pop
  end
end

class Route
  attr_reader :stations

  # Инициализация с приемом аргументов начальной и конечной станции
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  # Добавление промежуточной станции в список
  def add_station(station)
    @stations.insert(-2, station)
  end

  # Удаление недавно добавленной станции
  def del_station(station)
    @stations.delete(station)
  end
end

class Train
  attr_accessor :speed
  attr_reader :type, :number

  # Начальное создание класса с приемом произвольного номера поезда и приемом типа поезда "грузовой" или "пассажирский"
  def initialize(number, type)
    @type = type
    @number = number
    @speed = 0
    @wagon = 0
  end

  # добавление вагона
  def add_wagon
    if @speed.zero?
      @wagon += 1
    else
      puts 'Сначала нужно остановить поезд'
    end
  end

  # Удаление вагона
  def del_wagon
    if @wagon.zero?
      puts 'У поезда нет вагонов'
    elsif @speed.zero?
      @wagon -= 1
    else
      puts 'Сначала нужно остановить поезд'
    end
  end

  # остановка поезда
  def stop
    @speed = 0
  end

  # Принятие маршрута
  def submit_route(route, train)
    @route = route
    @number_station = 0
    @current_station = route.stations[0]
    @current_station.get_train(train)
  end

  # Отправление к следующей станции
  def go_to_next_station(train)
    return unless next_station

    current_station.send_train
    @number_station += 1
    current_station.get_train(train)
  end

  # Возвращение на станцию назад
  def back_to_previous_station(train)
    return unless previous_station

    @number_station != 0
    current_station.send_train
    @number_station -= 1
    current_station.get_train(train)
  end

  def current_station
    @route.stations[@number_station]
  end

  def previous_station
    if @number_station.zero?
      puts 'Поезд находится на начальной станции'
    else
      @route.stations[@number_station - 1]
    end
  end

  def next_station
    if (@number_station + 1) == @route.stations.length
      puts 'Поезд находится на конечной станции'
    else
      @route.stations[@number_station + 1]
    end
  end
end
