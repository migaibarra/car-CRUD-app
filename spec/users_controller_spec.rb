require 'spec_helper'

describe "Users Controller" do
  let(:user_example) { {
      first_name: "Samuel",
      last_name: "Adams",
      username: "drunken_goodness1792"
  } }

  it "redirects to the user page" do
    get '/'
    expect(last_response.status).to eq 302
  end

  it "gets the user index page" do
    get '/users'
    expect(last_response.status).to eq 200
  end

  it "gets the new user page" do
    get '/users/new'
    expect(last_response.status).to eq 200
  end

  context "user correctly registers with no problems" do
    it "redirects to the user show page" do
      post '/users', user: user_example
      expect(last_response.status).to eq 302
    end

    it "adds a new user object to the User class" do
      expect { post '/users', user: user_example }.to change{ User.all.count }.by 1
    end
  end
end
