class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end
  
  def show
    @restaurant = Restaurant.find_by(id: params[:id])
  end
  
  def destroy
    Restaurant.find_by(id: params[:id]).delete
    redirect_to restaurants_path
  end
end
