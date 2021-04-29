
class PassengerWagon < Wagon
  TYPE = 'passenger'
  attr_reader :occupied_seat, :free_seats

  def initialize(number, seat)
    super
    @type = 'passenger'
    @occupied_seat = 0
    @free_seats = seat
  end

  def take_a_seat
    @occupied_seat += 1
    @free_seats -= 1
  end

  def free_up
    @occupied_seat -= 1
    @free_seats += 1
  end
end
