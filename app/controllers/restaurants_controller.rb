class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant =Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    unless @restaurant.user_id == current_user.id
      flash[:notice] = 'You did not create this restaurant, troll!'
      redirect_to restaurants_path
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user_id == current_user.id
      @restaurant.update(restaurant_params)
    else
      flash[:notice] = 'You did not create this restaurant, troll!'
    end
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
      if @restaurant.user_id == current_user.id
        @restaurant.destroy
        flash[:notice] = 'Restaurant deleted successfully'
      else
        flash[:notice] = 'You did not create this restaurant, troll!'
      end
      redirect_to restaurants_path
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

end
