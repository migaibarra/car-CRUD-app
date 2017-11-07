class Car < ActiveRecord::Base
  belongs_to :user

  validates :make, presence: true
  validates :model, presence: true
  validates :horsepower, presence: true, numericality: { true, greater_than_or_equal_to: 0}
  validates :top_speed, presence: true, numericality: { true, greater_than_or_equal_to: 0}
end
