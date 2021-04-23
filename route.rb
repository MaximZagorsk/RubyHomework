# frozen_string_literal: true

require_relative 'instance_counter'
class Route
  include ::InstanceCounter
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

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate!
    raise 'First or second station is nil' if @stations[0].nil? || @stations[1].nil?
  end
end
