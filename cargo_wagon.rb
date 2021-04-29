
class CargoWagon < Wagon
  attr_reader :occupied_volume, :free_volume

  def initialize(number, volume)
    super
    @type = 'cargo'
    @free_volume = volume
    @occupied_volume = 0
  end

  def take_a_volume(take)
    @occupied_volume += take
    @free_volume -= take
  end

  def free_up_volume(take)
    @free_volume += take
    @occupied_volume -= take
  end
end
