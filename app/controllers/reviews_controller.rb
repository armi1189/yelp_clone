class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.user = current_user
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurants_path
    else
      flash[:notice] = 'You have already reviewed this restaurant.'
      render "new"
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

   def destroy
    @review = Review.find(params[:id])
    if current_user == @review.user
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
    else
      flash[:notice] = 'Cannot delete review'
    end
    redirect_to '/restaurants'
  end

end
