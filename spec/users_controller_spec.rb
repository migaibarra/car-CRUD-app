require 'spec_helper'

describe "Users Controller" do
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
end
