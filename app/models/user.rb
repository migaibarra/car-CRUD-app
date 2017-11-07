class User < ActiveRecord::Base
  has_many :cars

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true

  def add_car(car)
    return "Your garage is full! You cannot get any more cars" if self.cars > 5
    self.cars << car
  end
end
