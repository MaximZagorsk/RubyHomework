require_relative 'module_company'

class Train
  @@object = []
  include ::Company
  attr_accessor :speed
  attr_reader :type, :number

  class << self
    def find(number)
      @@object.find {|item| item.number == number}
    end
  end
  # Начальное создание класса с приемом произвольного номера поезда и приемом типа поезда "грузовой" или "пассажирский"
  def initialize(number)
    @type = TYPE
    @number = number
    @speed = 0
    @wagon = []
    @@object << self
  end

  # добавление вагона
  def add_wagon(wagon)
    @wagon << wagon if wagon.type == type
  end

  # Удаление вагона
  def del_wagon
    if @wagon.length.zero?
      puts 'У поезда нет вагонов'
    elsif @speed.zero?
      @wagon.pop
    else
      puts 'Сначала нужно остановить поезд'
    end
  end

  # остановка поезда
  def stop
    @speed = 0
  end

  # Принятие маршрута
  def submit_route(route)
    @route = route
    @number_station = 0
    @current_station = route.stations[0]
    @current_station.get_train(self)
  end

  # Отправление к следующей станции
  def go_to_next_station
    return unless next_station

    current_station.send_train(self)
    @number_station += 1
    current_station.get_train(self)
  end

  # Возвращение на станцию назад
  def back_to_previous_station
    return unless previous_station

    @number_station != 0
    current_station.send_train(self)
    @number_station -= 1
    current_station.get_train(self)
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

  TYPE = nil
end
