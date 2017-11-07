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
  
  describe "Validations"

end
