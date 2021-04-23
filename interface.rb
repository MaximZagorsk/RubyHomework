# frozen_string_literal: true

require_relative 'train'
require_relative 'wagon'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

class Interface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
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
  end

  # Методы управления программой должны быть недоступны извне

  private

  def manage_route
    loop do
      puts " 1. Создать маршрут.\n 2. Удалить маршрут\n 3. Изменить маршрут \n 4. Назад"
      user_input = gets.chomp
      case user_input
      when '1'
        create_route
      when '2'
        del_route
      when '3'
        change_route
      when '4'
        break
      end
    end
  end

  def manage_train
    loop do
      puts " 1. Создать поезд \n 2. Добавить вагон поезду \n 3. Отцепить вагон от поезда \n 4. Список вагонов поезда
 5. Установить маршрут поезду \n 6. Перемещение поезда \n 7. Назад"
      user_input = gets.chomp
      case user_input
      when '1'
        create_train
      when '2'
        add_wagon_to_train
      when '3'
        del_wagon_from_train(choose_train)
      when '4'
        print_wagon_by_train
      when '5'
        set_route_to_train
      when '6'
        moving_train
      when '7'
        break
      end
    end
  end

  def manage_stations
    loop do
      puts "\n 1. Создать станцию \n 2. Посмотреть список станций \n 3. Посмотреть список поездов на станции\n 4. Назад"
      user_input = gets.chomp
      case user_input
      when '1'
        create_station
      when '2'
        print_station_list
      when '3'
        print_train_list_on_station
      when '4'
        break
      end
    end
  end

  def create_station
    puts "\nВведите название станции:"
    name = gets.chomp
    @stations << Station.new(name)
  rescue StandardError
    puts "\nВы неправильно ввели имя станции, имя не должно быть пустой строкой"
    retry
  end

  def create_train
    puts "\nВведите номер поезда, а затем тип"
    number_train = gets.chomp
    type_train = gets.chomp
    case type_train
    when 'cargo'
      @trains << CargoTrain.new(number_train)
    when 'passenger'
      @trains << PassengerTrain.new(number_train)
    end
    puts 'Поезд успешно создан!'
  rescue StandardError
    puts "\nОшибка! \nВы ввели неправильные формат поезда, введите его в таком формате:
три буквы или цифры в любом порядке, необязательный дефис
(может быть, а может нет) и еще 2 буквы или цифры после дефиса"
    retry
  end

  def create_route
    puts "\nВведите начальную, а затем конечную станцию"
    input_station = gets.chomp
    station_start = @stations.find { |item| item.name == input_station }
    input_station = gets.chomp
    station_end = @stations.find { |item| item.name == input_station }
    @routes << Route.new(station_start, station_end)
  rescue StandardError
    puts "\nОдной из станций не существует, введите существующую станцию"
    retry
  end

  def add_wagon_to_train
    chose_train = choose_train
    puts 'Введите номер вагона'
    number = gets.chomp
    case chose_train.type
    when 'cargo'
      puts 'Введите объем вагона'
      value = gets.chomp
      chose_train.add_wagon(CargoWagon.new(number, value))
    when 'passenger'
      puts 'Введите количество сидячих мест'
      value = gets.chomp
      chose_train.add_wagon(PassengerWagon.new(number, value))
    end
  end

  def del_wagon_from_train(train)
    train.del_wagon
  end

  def print_wagon_by_train
    puts 'Выберите поезд'
    chose_train = choose_train
    case chose_train.type
    when 'cargo'
      chose_train.enumeration_wagon do |wagon|
        puts "Вагон №#{wagon.number} тип: #{wagon.type}, кол-во занятого объема: #{wagon.occupied_volume}
 кол-во свободного объема: #{wagon.free_volume}"
      end
    when 'passenger'
      chose_train.enumeration_wagon do |wagon|
        puts "Вагон №#{wagon.number} тип: #{wagon.type}, кол-во занятых мест: #{wagon.occupied_seat}
 кол-во свободных мест: #{wagon.free_seats}"
      end
    end
  end

  def del_route
    @routes.delete(@routes[choose_route.to_i - 1])
  end

  def change_route
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
  end

  def set_route_to_train
    puts 'Выберети поезд из списка:'
    chose_train = choose_train
    select_route = @routes[choose_route.to_i - 1]
    chose_train.submit_route(select_route)
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

  def print_station_list
    @stations.each { |item| puts item.name }
  end

  def print_train_list_on_station
    puts 'Выберите станцию'
    @stations.each(&:name)
    input_name_station = gets.chomp
    select = @stations.find { |item| item.name == input_name_station }
    select.train_enumeration do |train|
      puts "Поезд №#{train.number}, тип:#{train.type}, вагонов: #{train.wagon.count}"
    end
  end

  def moving_train
    chose_train = choose_train
    puts " 1. Переместить на станцию вперед \n 2. Переместить на станцию назад"
    select = gets.chomp
    case select
    when '1'
      chose_train.go_to_next_station
    when '2'
      chose_train.back_to_previous_station
    end
  end
end
