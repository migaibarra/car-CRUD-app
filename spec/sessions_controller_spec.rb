require 'spec_helper'

describe "Session Creation and Login" do
  let!(:user_example) { User.create!(
    first_name: "Haley",
    last_name: "Simpson",
    username: "haleyscomet86",
    email: "hcomet89@example.com",
    password: "DukH8tr")
  }

  it 'gets to the login page' do
    get '/sessions/new'
    expect(last_response.status).to eq 200
  end

  context "when the user logs in correctly" do
    it 'redirects to the user profile page' do
      post '/sessions', { email: user_example.email, password: "DukH8tr" }
      expect(last_response.status).to eq 302
    end

    it 'sets the session[:user_id] to the user id' do
      post '/sessions', { email: user_example.email, password: "DukH8tr" }
      expect(session[:user_id]).to eq user_example.id
    end
  end

  context "when the user does not login correctly" do
    it 'does not redirect to the user profile page/renders the login page again' do
      post '/sessions', { email: user_example.email, password: "DuckHater" }
      expect(last_response.status).to eq 200
    end
    it 'renders errors on the login page' do
      post '/sessions', { email: user_example.email, password: "DuckHater" }
      expect(last_response.body).to include 'Oops, something went wrong!'
    end
  end

  it 'clears the session when the user logs out' do
    post '/sessions', { email: user_example.email, password: "DukH8tr" }
    expect(session[:user_id]).to eq user_example.id
    delete "/sessions/#{session[:user_id]}"
    expect(session[:user_id]).to be nil
  end
end
