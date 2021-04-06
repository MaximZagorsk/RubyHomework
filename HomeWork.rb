class Station
  attr_reader :name
  attr_reader :trains
  #При инициализации класса определяется его имя
  def initialize(name)
    @name = name
    #Пустой список колличества поездов на станции
    @trains = []
  end

  #Прием поезда
  def get_train(train)
    @trains.push(train)
  end

  #Возвращение списка поездов на станции по типу
  def print_trains_by_type(type)
    choose_trains = []
    for counter in @trains
      if counter.type == type
        choose_trains.push(counter)
      end
    end
    return choose_trains
  end

  #Удаление поезда со станции
  def send_train
    @trains.pop
  end
end

class Route
  attr_reader :stations

  #Инициализация с приемом аргументов начальной и конечной станции
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  #Добавление промежуточной станции в список
  def add_station(station)
    @stations.insert(2, station)
  end

  #Удаление недавно добавленной станции
  def del_station
    @stations.delete_at(2)
  end

end

class Train
  attr_accessor :speed
  attr_reader :type
  attr_reader :number

  #Начальное создание класса с приемом произвольного номера поезда и определенного типа 'п' - пассажирский и 'г' - грузовой
  def initialize(number, type)
    if type == 'п'
      @type = "пассажирский"
    elsif type == 'г'
      @type = "грузовой"
    end
    @number = number
    @speed = 0
    @wagon = 0
  end

  #добавление вагона
  def add_wagon
    if @speed == 0
      @wagon += 1
    else
      puts 'Сначала нужно остановить поезд'
    end
  end

  #Удаление вагона
  def del_wagon
    if @wagon == 0
      puts 'У поезда нет вагонов'
    else
      if @speed == 0
        @wagon -= 1
      else
        puts 'Сначала нужно остановить поезд'
      end
    end
  end

  #остановка поезда
  def stop
    @speed = 0
  end

  #Принятие маршрута
  def submit_route(route, train)
    @route = route
    @number_station = 0
    @current_station = route.stations[0]
    @current_station.get_train(train)
  end

  #Отправление к следующей станции
  def go_to_next_station(train)
    if (@number_station + 1) == @route.stations.length
      puts 'Конечная станция, ехать можно только назад'
    else
      @route.stations[@number_station].send_train
      @number_station += 1
      @current_station = @route.stations[@number_station]
      @current_station.get_train(train)
    end
  end

  #Возвращение на станцию назад
  def back_to_last_station(train)
    if @number_station != 0
      @route.stations[@number_station].send_train
      @number_station -= 1
      @current_station = @route.stations[@number_station]
      @current_station.get_train(train)
    else
      puts 'Поезд находится в начальой точке маршрута'
    end
  end

  def last_station
    if @number_station == 0
      puts "Поезд находится на начальной станции"
    else
      return @route.stations[@number_station - 1]
    end
  end

  def next_station
    if (@number_station + 1) == @route.stations.length
      puts 'Поезд находится на конечной станции'
    else
      return @route.stations[@number_station + 1]
    end
  end

  #Вывод предыдущей, текущей, следующей станции
  def print_lcn_station

    if @number_station == 0
      puts "Это начальная станция #{@current_station.name}, следующая станция #{next_station.name}"
    elsif (@number_station + 1) == @route.stations.length
      puts "Это конечная станция #{@current_station.name}, предыдущая станция #{last_station.name}"
    else
      puts "Текущая станция #{@current_station.name}, предыдущая станция #{last_station.name}, следующая станция #{next_station.name}"
    end
  end
end