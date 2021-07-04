require 'spec_helper'

describe "Cars Controller" do
  let!(:user_example) {User.create(
      first_name: "Ace",
      last_name: "Flash",
      email: "aFlash_of_lightning99@example.com",
      username: "aFlash_of_lightning99",
      password: "nothing2c"
    )
  }

  # before(:each) { User.authenticate("aFlash_of_lightning99@example.com", "nothing2c") }

  let(:car_data) { {
      make: "Subaru",
      car_model: "WRX STI",
      engine: "2.0-liter turbo 4-cylinder BOXER",
      transmission: "All-Wheel Drive",
      horsepower: 305,
      top_speed: 155
    } }

  it 'gets the cars index page for a particular user' do
    User.authenticate("aFlash_of_lightning99@example.com", "nothing2c")
    get "/users/#{user_example.id}/cars"
    expect(last_response.status).to eq 200
  end

  it 'gets the new car page' do
    get "/users/#{user_example.id}/cars/new"
    expect(last_response.status).to eq 200
  end

  context "user adds a new car to his or her garage with all valid data" do
    it "redirects to the user's car index page" do
      post "/users/#{user_example.id}/cars", car: car_data
      expect(last_response.status).to eq 302
    end

    it 'adds a new car to the car class' do
      expect { post "/users/#{user_example.id}/cars", car: car_data }.to change { Car.count }.by 1
    end

    it "associates the new car to the user's page" do
      post "/users/#{user_example.id}/cars", car: car_data
      expect(user_example.cars).to include Car.find_by(user_id: user_example.id)
    end
  end

  context "user has an error when filling in a new car form" do
    it 'does renders the same new form page if user does not correctly fill in data correctly' do
      car_data[:car_model] = ''
      post "/users/#{user_example.id}/cars", car: car_data
      expect(last_response.status).to eq 200
    end

    it 'renders errors on the page' do
      car_data[:car_model] = ''
      post "/users/#{user_example.id}/cars", car: car_data
      expect(last_response.body).to include "Car model can't be blank"
    end
  end

  it 'gets the car show page' do
    car_example = Car.create(car_data)
    user_example.cars << car_example
    get "/users/#{user_example.id}/cars/#{car_example.id}"
    expect(last_response.status).to eq 200
  end

  it 'gets the car edit page' do
    car_example = Car.create(car_data)
    user_example.cars << car_example
    get "/users/#{user_example.id}/cars/#{car_example.id}/edit"
    expect(last_response.status).to eq 200
  end

  it "updates a user's car" do
    car_example = Car.create(car_data)
    user_example.cars << car_example
    put "/users/#{user_example.id}/cars/#{car_example.id}", car: { top_speed: 130 }
    expect(Car.find(car_example.id).top_speed).to eq 130
  end

  it "deletes a user's car" do
    car_example = Car.create(car_data)
    user_example.cars << car_example
    delete "/users/#{user_example.id}/cars/#{car_example.id}"
    expect(Car.all).to_not include car_example
  end
end
