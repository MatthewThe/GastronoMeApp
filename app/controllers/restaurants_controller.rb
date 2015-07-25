class RestaurantsController < ApplicationController
  before_action :get_restaurant, only: [:show, :edit, :update, :review, :submit_review]
  
  def index
    if params[:utf8]
      if params[:mode] == "map"
        redirect_to "/map/search/#{params[:search]}"
        return
      else
        redirect_to "/restaurants/search/#{params[:search]}"
        return
      end
    end
    @tags = ActsAsTaggableOn::Tag.most_used(10)
    if params[:tag].present?
      if params[:tag] == "unreviewed"
        @restaurants = Restaurant.where("reviews_count = ?", 0)
      else
        @restaurants = Restaurant.tagged_with(params[:tag])
      end
    elsif params[:search].present?
      @restaurants = Restaurant.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
      if @restaurants.count == 1
        if params[:mode] == "map"
          redirect_to map_restaurant_path(@restaurants.first)
        else
          redirect_to @restaurants.first
        end
        return
      end
    else
      @restaurants = Restaurant.all
    end
    
    if params[:mode] == "map"
      render :action => "map"
    end
  end

  def show
    if params[:mode] == "map"
      render :action => "map_restaurant"
    end
  end
  
  def new
    @restaurant = Restaurant.new
  end
  
  def create
    @restaurant = Restaurant.new(params_restaurant)
    if @restaurant.save
      redirect_to @restaurant
    else
      redirect_to 'restaurants'
    end
  end
  
  def edit
  end
  
  def update
    @restaurant.update(params_restaurant)
    redirect_to @restaurant
  end
  
  def review
    @review = Review.new
  end
  
  def submit_review
    @review = Review.new(params_review)
    @review.restaurant = @restaurant
    if @review.save
      redirect_to @review
    else
      redirect_to @restaurant
    end
  end
  
  def destroy
    Restaurant.find_by(id: params[:id]).destroy
    redirect_to restaurants_path
  end
  
  def get_restaurant
    @restaurant = Restaurant.find_by(id: params[:id])
  end
  
  private
  def params_review
    params.require(:review).permit(:date, :review, :food, :with, :rating_atmosphere, :rating_service, :rating_food, :rating_location, :rating_overall)
  end
  
  private
  def params_restaurant
    params.require(:restaurant).permit(:name, :website, :address, :district, :image, :price, :tag_list)
  end
end
