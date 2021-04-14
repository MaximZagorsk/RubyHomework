class Route
  include ::InstanceCounter
  attr_reader :stations

  @instance = 0
  # Инициализация с приемом аргументов начальной и конечной станции
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instances
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
