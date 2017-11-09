require 'spec_helper'

describe "Users Controller" do
  let(:user_example) { {
      first_name: "Samuel",
      last_name: "Adams",
      username: "drunken_goodness1792"
  } }

  it 'redirects to the user page' do
    get '/'
    expect(last_response.status).to eq 302
  end

  it 'gets the user index page' do
    get '/users'
    expect(last_response.status).to eq 200
  end

  it 'gets the new user page' do
    get '/users/new'
    expect(last_response.status).to eq 200
  end

  context "user correctly registers with no problems" do
    it 'redirects to the user show page' do
      post '/users', user: user_example
      expect(last_response.status).to eq 302
    end

    it 'adds a new user object to the User class' do
      expect { post '/users', user: user_example }.to change{ User.all.count }.by 1
    end
  end

  context "user does not correctly fill in the form" do
    it 'renders the form page' do
      user_example[:username] = ''
      post '/users', user: user_example
      expect(last_response.status).to eq 200
    end

    it "displays errors on the form" do
      user_example[:username] = ''
      post '/users', user: user_example
      expect(last_response.body).to include("Username can't be blank")
    end
  end

  it 'gets the user show page' do
    saved_user_example = User.create(first_name: user_example[:first_name], last_name: user_example[:last_name], username: user_example[:username])
    get "/users/#{saved_user_example.id}"
    expect(last_response.status).to eq 200
  end

  it 'gets the user edit page' do
    saved_user_example = User.create(first_name: user_example[:first_name], last_name: user_example[:last_name], username: user_example[:username])
    get "/users/#{saved_user_example.id}/edit"
    expect(last_response.status).to eq 200
  end

  it "can update a user's info" do
    saved_user_example = User.create(first_name: user_example[:first_name], last_name: user_example[:last_name], username: user_example[:username])
    put "/users/#{saved_user_example.id}", user: {username: 'something_else2017'}
    expect(User.find(saved_user_example.id).username).to eq "something_else2017"
  end

  it "can delete a user" do
    saved_user_example = User.create(first_name: user_example[:first_name], last_name: user_example[:last_name], username: user_example[:username])
    delete "/users/#{saved_user_example.id}"
    expect(User.all).to_not include saved_user_example
  end
end
