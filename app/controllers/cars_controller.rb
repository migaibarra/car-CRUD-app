get '/users/:user_id/cars' do
  @user = User.find(params[:user_id])
  @cars = @user.cars
  erb :'/cars/index'
end

get '/users/:user_id/cars/new' do
  @user = User.find(params[:user_id])
  @car = Car.new
  erb :'/cars/new'
end

post '/users/:user_id/cars' do
  @user = User.find(params[:user_id])
  @car = Car.new(params[:car])
  if @car.save
    @user.cars << @car
    redirect :'/users/:user_id/cars'
  else
    @errors = @car.errors.full_messages
    erb :'/cars/new'
  end
end

get '/users/:user_id/cars/:id' do
  @car = Car.find(params[:id])
  erb :'/cars/show'
end

get '/users/:user_id/cars/:id/edit' do
  @user = User.find(params[:user_id])
  @car = Car.find(params[:id])
  erb :'/cars/edit'
end
