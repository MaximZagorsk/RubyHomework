require_relative 'train'
require_relative 'wagon'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

def create_station(name)
  Station.new(name)
end

def create_train(number, type)
  case type
  when 'cargo'
    CargoTrain.new(number)
  when 'passenger'
    PassengerTrain.new(number)
  end
end

def create_wagon(type)
  case type
  when 'cargo'
    CargoWagon.new
  when 'passenger'
    PassengerWagon.new
  end
end

def create_route(start_station, end_station)
  Route.new(start_station, end_station)
end

def add_wagon_to_train(train, wagon)
  train.add_wagon(wagon)
end

def del_wagon_from_train(train)
  train.del_wagon
end

def choose_train
  puts 'Выберет поезд из списка:'
  @trains.each { |items| puts "Поезд  №#{items.number}" }
  chose_train = gets.chomp
  @trains.find { |items| items.number == chose_train }
end

def choose_route
  puts 'Выберите маршрут из списка'
  @routes.each { |item| puts "Маршрут #{@routes.index(item) + 1} " }
  gets.chomp
end

def manage_route
  while TRUE
    puts " 1. Создать маршрут.\n 2. Удалить маршрут\n 3. Изменить маршрут \n 4. Назад"
    user_input = gets.chomp
    case user_input
    when '1'
      puts 'Введите начальную, а затем конечную станцию'
      input_station = gets.chomp
      station_start = @stations.find { |item| item.name == input_station }
      input_station = gets.chomp
      station_end = @stations.find { |item| item.name == input_station }
      @routes << create_route(station_start, station_end)
    when '2'
      @routes.delete(@routes[choose_route.to_i - 1])
    when '3'
      select_route = @routes[choose_route.to_i - 1]
      select_route.stations.each { |item| puts item.name }
      puts "Выберите действие: \n 1. Добавить промежуточную станцию \n 2. Удалить станцию"
      user_input = gets.chomp
      case user_input
      when '1'
        puts 'Введите имя станции'
        name_station = gets.chomp
        select_route.add_station(@stations.find { |item| item.name == name_station })
      when '2'
        puts 'Введите имя станции'
        name_station = gets.chomp
        select_route.del_station(@stations.find { |item| item.name == name_station })
      end
    when "4"
      break
    end
  end
end

def manage_train
  while TRUE
    puts " 1. Создать поезд \n 2. Добавить вагон поезду \n 3. Отцепить вагон от поезда \n 4. Установить маршрут поезду
 5. Перемещение поезда \n 6. Назад"
    user_input = gets.chomp
    case user_input
    when '1'
      puts 'Введите номер поезда, а затем тип'
      number_train = gets.chomp
      type_train = gets.chomp
      @trains << create_train(number_train, type_train)
    when '2'
      chose_train = choose_train
      add_wagon_to_train(chose_train, create_wagon(chose_train.type))
    when '3'
      del_wagon_from_train(choose_train)
    when '4'
      puts 'Выберет поезд из списка:'
      chose_train = choose_train
      select_route = @routes[choose_route.to_i - 1]
      chose_train.submit_route(select_route)
    when '5'
      chose_train = choose_train
      puts " 1. Переместить на станцию вперед \n 2. Переместить на станцию назад"
      select = gets.chomp
      case select
      when '1'
        chose_train.go_to_next_station
      when '2'
        chose_train.back_to_previous_station
      end
    when '6'
      break
    end
  end
end

def manage_stations
  while TRUE
    puts " 1. Создать станцию \n 2. Посмотреть список станций \n 3. Посмотреть список поездов на станции\n 4. Назад"
    user_input = gets.chomp
    case user_input
    when '1'
      puts 'Введите название станции:'
      name = gets.chomp
      @stations << create_station(name)
    when '2'
      @stations.each { |item| puts item.name }
    when '3'
      puts 'Выберите станцию'
      @stations.each { |item| item.name }
      input_name_station = gets.chomp
      select = @stations.find { |item| item.name == input_name_station }
      select.trains.each { |item| puts item.number }
    when '4'
      break
    end
  end
end

@stations = []
@trains = []
@routes = []
while TRUE
  puts " 1. Управление станциями \n 2. Управление поездами\n 3. Управление маршрутом.\n 4. Выход"
  user_input = gets.chomp
  case user_input
  when '1'
    manage_stations
  when '2'
    manage_train
  when '3'
    manage_route
  when '4'
    break
  end
end
