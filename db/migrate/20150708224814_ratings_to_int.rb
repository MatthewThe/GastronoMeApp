class RatingsToInt < ActiveRecord::Migration
  def change
    change_column :reviews, :rating_atmosphere, :integer
    change_column :reviews, :rating_service, :integer
    change_column :reviews, :rating_food, :integer
    change_column :reviews, :rating_location, :integer
  end
end
