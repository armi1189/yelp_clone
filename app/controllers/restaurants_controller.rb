class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @new_restaurant = new_restaurant_path
  end

  def new
  end

  def create
    Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
