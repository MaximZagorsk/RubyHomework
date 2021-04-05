class Station
  attr_reader :name
  #При инициализации класса определяется его имя
  def initialize(name)
    @name = name
    #Пустой список колличества поездов на станции
    @train_array = Array.new()
  end

  #Прием поезда
  def get_train(train)
    @train_array.push(train)
  end

  #Возвращение списка всех поездов на станции
  def print_train_list
    for counter in @train_array
      puts "Поезд с номером #{counter.number}"
    end
  end

  #Возвращение списка поесздов на станции по типу
  def print_trains_by_type
    cargo = 0
    passenger = 0
    for counter in @train_array
      if counter.type == "грузовой"
        cargo += 1
      elsif counter.type == "пассажирский"
        passenger += 1
      end
    end
    puts "На платформе находится #{cargo} грузовых и #{passenger} пассажирских"
  end

  #Удаление поезда со станции
  def send_train
    @train_array.pop
  end
end

class Route
  attr_reader :station_array

  #Инициализация с приемом аргументов начальной и конечной станции
  def initialize(start_station, end_station)
    @station_array = Array.new()
    @station_array.push(start_station, end_station)
  end

  #Добавление промежуточной станции в список
  def add_station(station)
    @station_array.insert(2, station)
  end

  #Удаление недавно добавленной станции
  def del_station
    @station_array.delete_at(2)
  end

  "Вывод всех станций по порядку от начальной до конечной"
  def print_all_station
    i = 1
    for count in @station_array
      puts "Станция #{i} #{count.name}"
      i += 1
    end
  end
end

class Train
  attr_accessor :speed
  attr_reader :type
  attr_reader :number

  #Начальное создание класса с приемом произвольного номера поезда и определенного типа 1 - пассажирский и 2 - грузовой
  def initialize(number, type)
    if type == 1
      @type = "пассажирский"
    elsif type == 2
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
  def submit_route(route)
    @route = route
    @number_station = 0
    @start_station = route.station_array[0]
    @current_station = @start_station
  end

  #Отправление к следующей станции
  def go_to_next_station(train)
    if (@number_station + 1) == @route.station_array.length
      puts 'Конечная станция, ехать можно только назад'
    else
      @route.station_array[@number_station].send_train
      @number_station += 1
      @current_station = @route.station_array[@number_station]
      @current_station.get_train(train)
    end
  end

  #Возвращение на станцию назад
  def back_to_last_station(train)
    if @number_station != 0
      @route.station_array[@number_station].send_train
      @number_station -= 1
      @current_station = @route.station_array[@number_station]
      @current_station.get_train(train)
    else
      puts 'Поезд находится в начальой точке маршрута'
    end
  end

  #Печать l - last - предыдущей, c - current - текущей n - next -следующей станции
  def print_lcn_station

    if @number_station == 0
      puts "Это начальная станция #{(@route.station_array[@number_station]).name}, следующая станция #{(@route.station_array[@number_station + 1]).name}"
    elsif (@number_station + 1) == @route.station_array.length
      puts "Это конечная станция #{(@route.station_array[@number_station]).name}, предыдущая станция #{(@route.station_array[@number_station - 1]).name}"
    else
      puts "Текущая станция #{(@route.station_array[@number_station]).name}, предыдущая станция #{(@route.station_array[@number_station - 1]).name}, следующая станция #{(@route.station_array[@number_station + 1]).name}"
    end

  end
end