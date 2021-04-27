
require_relative 'instance_counter'
require_relative 'validate_module'
class Station
  include ::InstanceCounter
  include ::Validation

  validate :name, :validate_presence
  @@all = []
  attr_reader :name, :trains

  class << self
    def all
      @@all
    end
  end

  # При инициализации класса определяется его имя
  def initialize(name)
    @name = name
    # Пустой список колличества поездов на станции
    @trains = []
    @@all << self
    register_instances
    validate!
  end

  # Прием поезда
  def get_train(train)
    @trains.push(train)
  end

  # Возвращение списка поездов на станции по типу
  def get_trains_by_type(type)
    @trains.select { |item| item.type == type }
  end

  # Удаление поезда со станции
  def send_train(train)
    @trains.delete(train)
  end

  def train_enumeration(&block)
    @trains.each { |item| block.call(item) }
  end
end
