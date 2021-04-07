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
  if type == "cargo"
    CargoTrain.new(number)
  elsif type == "passenger"
    PassengerTrain.new(number)
  end
end

def create_route(start_station, end_station)
  Route.new(start_station, end_station)
end

def add_station_to_route(station, route)
  route.add_station(station)
end

def del_station_from_route(station, route)
  route.del_station(station)
end

def set_train_route(route, train)
  train.submit_route(route)
end

def add_wagon_to_train(train, wagon)
  train.add_wagon(wagon)
end

def del_wagon_from_train(train, wagon)
  train.del_wagon(wagon)
end

def send_train_to_next_station(train)
  train.go_to_next_station
end

def send_train_to_previous_station(train)
  train.back_to_previous_station
end

def return_list_station
  @stations
end

def return_train_list_on_station(station)
  station.trains
end

while TRUE
  puts " 1. Создать станцию.\n 2.Создать оезд.п\n 3. Cоздать маршрут.\n 4. Перемещение поезда"
  gets
end