class ReviewsController < ApplicationController
  before_action :get_review, only: [:show, :edit, :update]
  
  def index
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    @current_tag = ''
    if params[:tag].present?
      @restaurants = Restaurant.tagged_with(params[:tag])
      @reviews = []
      @restaurants.each do |r|
        @reviews += r.reviews
      end
      @reviews = @reviews.sort_by{|r| -r.rating_overall}
      @current_tag = params[:tag]
    else
      @reviews = Review.order(rating_overall: :desc)
    end
  end
  
  def show
  end
  
  def new
    @review = Review.new
    if params[:restaurant].present?
      @restaurant = Restaurant.find_by(id: params[:restaurant])
    else
      @restaurant = Restaurant.new
    end
  end
  
  def create
    review = Review.new(params_review)
    if params[:restaurant][:id].present?
      restaurant = Restaurant.find_by(id: params[:restaurant][:id].to_i)
      restaurant.attributes = params_existing_restaurant
    else
      restaurant = Restaurant.new(params_restaurant)
    end
    review.restaurant = restaurant
    if review.save
      if restaurant.save
        redirect_to review
      else
        review.delete()
        redirect_to 'reviews'
      end
    end
  end
  
  def edit
  end
  
  def update
    @review.update(params_review)
    @restaurant.update(params_restaurant)
    redirect_to @review
  end
  
  def destroy
    Review.find_by(id: params[:id]).destroy
    redirect_to reviews_path
  end
  
  def get_review
    @review = Review.find_by(id: params[:id])
    @restaurant = @review.restaurant
  end
  
  private
  def params_review
    params.require(:review).permit(:date, :review, :food, :with, :rating_atmosphere, :rating_service, :rating_food, :rating_location, :rating_overall)
  end
  
  private
  def params_restaurant
    params.require(:restaurant).permit(:name, :website, :address, :district, :image, :price, :tag_list)
  end
  
  private
  def params_existing_restaurant
    params.require(:restaurant).except(:id).permit(:name, :website, :address, :district, :image, :price, :tag_list)
  end
end
