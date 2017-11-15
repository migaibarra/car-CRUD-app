get '/users/:user_id/cars' do
  @user = User.find(params[:user_id])
  @cars = @user.cars
  erb :'/cars/index'
end

get '/users/:user_id/cars/new' do
  @user = User.find(params[:user_id])
  @car = Car.new
  if request.xhr?
    erb :'/cars/new', layout: false
  else
    erb :'/cars/new'
  end
end

post '/users/:user_id/cars' do
  @user = User.find(params[:user_id])
  @car = Car.new(params[:car])
  if request.xhr?
    if @car.save
      @user.cars << @car
      @car.to_json
      erb :'/cars/_car_item', locals: { car: @car, user: @user }, layout: false
    # else # implementing errors laterz
    end
  else
    if @car.save
      @user.cars << @car
      redirect :"/users/#{@user.id}/cars"
    else
      @errors = @car.errors.full_messages
      erb :'/cars/new'
    end
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

put '/users/:user_id/cars/:id' do
  @user = User.find(params[:user_id])
  @car = Car.find(params[:id])
  @car.update(params[:car])
  if @car.save
    redirect "/users/#{@user.id}/cars/#{@car.id}"
  else
    @errors = car.errors.full_messages
    erb :'/cars/edit'
  end
end

delete '/users/:user_id/cars/:id' do
  user = User.find(params[:user_id])
  car = Car.find(params[:id])
  car.destroy
  redirect "/users/#{user.id}/cars"
end
