require 'spec_helper'

describe Car do
    let(:user_example) { User.new(
      first_name: 'Sarah',
      last_name: 'Somebody',
      username: 'muscle_girl89')
    }

    let(:car_example) { Car.new(
      make: "Honda",
      car_model: "Civic",
      horsepower: 187,
      top_speed: 135)
    }

  describe "Validations" do
    it 'is not valid without a make' do
      car_example.make = ''
      expect(car_example).to_not be_valid
    end

    it 'is not valid without a car_model' do
      car_example.car_model = ''
      expect(car_example).to_not be_valid
    end

    it 'is not valid without a horsepower' do
      car_example.horsepower = nil
      expect(car_example).to_not be_valid
    end

    it 'is not valid with a non-numerical horsepower value' do
      car_example.horsepower = 'one hundred eighty seven'
      expect(car_example).to_not be_valid
    end

    it 'is not valid without a top_speed' do
      car_example.top_speed = nil
      expect(car_example).to_not be_valid
    end

    it 'is not valid with a non-numerical top_speed value' do
      car_example.top_speed = '130 mph'
      expect(car_example).to_not be_valid
    end
  end

end
