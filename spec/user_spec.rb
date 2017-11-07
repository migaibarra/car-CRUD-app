require 'spec_helper'

describe User do
  describe "Validations" do
    let(:user_example) { User.new(
      first_name: 'Sarah',
      last_name: 'Somebody',
      username: 'muscle_girl89') }

    it 'is not valid without a first_name' do
      user_example.first_name = ''
      expect(user_example).to_not be_valid
    end

    it 'is not valid without a last_name' do
      user_example.last_name = ''
      expect(user_example).to_not be_valid
    end

    it 'is not valid without a username' do
      user_example.username = ''
      expect(user_example).to_not be_valid
    end
  end
end
