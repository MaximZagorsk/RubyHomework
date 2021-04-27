
require_relative 'instance_counter'
require_relative 'validate_module'
class Route
  include ::InstanceCounter
  include ::Validation
  validate :stations, :validate_presence
  attr_reader :stations

  # Инициализация с приемом аргументов начальной и конечной станции
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instances
    validate!
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
