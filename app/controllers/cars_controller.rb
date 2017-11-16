get '/users/:user_id/cars' do
  # if session[:user_id]
    @user = User.find(params[:user_id])
    @cars = @user.cars
    erb :'/cars/index'
  # else
  #   redirect "/sessions/new"
  # end
end

get '/users/:user_id/cars/new' do
  # if session[:user_id]
    @user = User.find(params[:user_id])
    @car = Car.new
    if request.xhr?
      erb :'/cars/new', layout: false
    else
      erb :'/cars/new'
    end
  # else
  #   redirect "/sessions/new"
  # end
end

post '/users/:user_id/cars' do
  # if session[:user_id]
    @user = User.find(params[:user_id])
    @car = Car.new(params[:car])
    if @car.save
      @user.add_car(@car)
      if request.xhr?
        erb :'/cars/_car_item', locals: { car: @car, user: @user }, layout: false
      else
        redirect "/users/#{@user.id}/cars"
      end
    else
      @errors = @car.errors.full_messages
      erb :'/cars/new'
    end
  # else
  #   redirect "/sessions/new"
  # end
end

get '/users/:user_id/cars/:id' do
  # if session[:user_id]
    @car = Car.find(params[:id])
    erb :'/cars/show'
  # else
  #   redirect "/sessions/new"
  # end
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
