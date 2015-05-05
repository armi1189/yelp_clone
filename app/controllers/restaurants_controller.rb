class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @new_restaurant = new_restaurant_path
  end

  def new
  end
end
