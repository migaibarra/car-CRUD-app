require 'spec_helper'

describe User do
  let(:user_example) { User.new(
      first_name: 'Sarah',
      last_name: 'Somebody',
      email: 'sarahomebody@example.org',
      username: 'muscle_girl89',
      password: 'thePassw0rd'
    )
  }

  let(:car_example) { Car.new(
        make: "Honda",
        car_model: "Civic",
        horsepower: 187,
        top_speed: 135
      )
    }

  describe "Validations" do
    it 'is not valid without a first_name' do
      user_example.first_name = ''
      expect(user_example).to_not be_valid
    end

    it 'is not valid without a last_name' do
      user_example.last_name = ''
      expect(user_example).to_not be_valid
    end

    it 'is not valid without an email' do
      user_example.email = ''
      expect(user_example).to_not be_valid
    end

    it 'is not valid if the email is not unique' do
      user_example.save
      user_duplicate = User.new(first_name: 'Sarah', last_name: 'Homey', email: 'sarahomebody@example.org', username: 'speed_demon91', password: 's0methingElse')
      expect(user_duplicate).to_not be_valid
    end

    it 'is not valid without a username' do
      user_example.username = ''
      expect(user_example).to_not be_valid
    end

    it 'is not valid if the username is not unique' do
      user_example.save
      user_duplicate = User.new(first_name: 'Susy', last_name: 'Sassy', email: 'sassy_girl@example.com', username: 'muscle_girl89', password: 's0methingElse')
      expect(user_duplicate).to_not be_valid
    end

    it 'is valid with a first_name, last_name, email, username, and password' do
      expect(user_example).to be_valid
    end
  end

  describe "Associations" do
    it 'starts out with no cars associated with it' do
      expect(user_example.cars.length).to eq 0
    end

    it 'can have a car associated with the user' do
      user_example.cars << car_example
      expect(user_example.cars).to include car_example
    end

    it 'can be associated with multiple cars' do
      user_example.cars << car_example
      user_example.cars << car_example
      user_example.cars << car_example
      expect(user_example.cars.length).to eq 3
    end
  end

  describe "Methods" do
    it 'has an .add_car method to add cars' do
      user_example.add_car(car_example)
      expect(user_example.cars).to include car_example
    end

    it 'cannot add more than 5 cars per user' do
      10.times { user_example.add_car(car_example) }
      expect(user_example.cars.length).to eq 5
    end

    it 'returns a message if more than 5 cars are attempted to be added' do
      5.times { user_example.add_car(car_example) }
      expect(user_example.add_car(car_example)).to eq "Your garage is full! You cannot add any more cars."
    end
  end
end
