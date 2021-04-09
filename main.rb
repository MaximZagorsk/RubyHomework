require_relative 'interface'

interface = Interface.new
loop do
  puts " 1. Управление станциями \n 2. Управление поездами\n 3. Управление маршрутом.\n 4. Выход"
  user_input = gets.chomp
  case user_input
  when '1'
    interface.manage_stations
  when '2'
    interface.manage_train
  when '3'
    interface.manage_route
  when '4'
    break
  end
end
