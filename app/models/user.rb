class User < ActiveRecord::Base
  has_many :cars

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true

  def add_car(car)
    return "Your garage is full! You cannot add any more cars." if self.cars.length >= 5
    self.cars << car
  end
end
