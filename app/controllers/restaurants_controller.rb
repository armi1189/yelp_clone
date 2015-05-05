class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @new_restaurant = new_restaurant_path
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
