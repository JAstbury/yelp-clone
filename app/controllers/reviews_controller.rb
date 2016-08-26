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
  @restaurant = Restaurant.find params[:restaurant_id]
  @review = @restaurant.reviews.build_with_user review_params, current_user

  if @review.save
    redirect_to restaurants_path
  else
    if @review.errors[:user]
      redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
    else
      render :new
    end
  end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
