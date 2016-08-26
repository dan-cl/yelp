class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed? @restaurant
      flash[:notice] = 'Troll!!'
      redirect_to '/restaurants'
    else
      @review = Review.new
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    binding.pry
    review = @restaurant.reviews.build_with_user(review_params, current_user)
    # review.user_id = current_user.id
    review.save
    redirect_to '/restaurants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
