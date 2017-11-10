get '/sessions/new' do
  erb :'/sessions/new'
end

post '/sessions' do
  user = User.login(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @error = "Oops, something went wrong! Please enter your username or email correctly along with your password"
    erb :'/sessions/new'
  end
end
