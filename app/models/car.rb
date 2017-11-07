class Car < ActiveRecord::Base
  belongs_to :user

  validates :make, presence: true
  validates :model, presence: true
  validates :horsepower, presence: true, numericality: true
  validates :top_speed, presence: true, numericality: true
end
