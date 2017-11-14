require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  
  has_many :cars

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
    message: "The email is not properly formatted (i.e. joe.someguy@example.com)" }
  validates :password_hash, presence: true

  def add_car(car)
    return "Your garage is full! You cannot add any more cars." if self.cars.length >= 5
    self.cars << car
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.login(email, password)
    user = User.find_by_email(email)
    if user.password == password
      return user
    else
      nil
    end
  end
end
