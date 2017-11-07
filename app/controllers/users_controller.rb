get '/' do
  redirect '/users'
end

get '/users' do
  @users = User.all
  erb :'/users/index'
end

get '/users/new' do
  @user = User.new
  erb :'/users/new'
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    redirect '/users'
  else
    @errors = user.errors.full_messages
    erb :'/users/new'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'/users/edit'
end

put '/users' do
  user = User.update(params[:user])
  if user.save
    redirect '/users'
  else
    @errors = user.errors.full_messages
    erb :'/users/new'
  end
end

delete '/users/:id' do
  user = User.find(params[:id])
  user.destroy
  redirect '/users'
end
