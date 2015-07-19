class AddReviewsCount < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :reviews_count, :integer, null:false, default: 0
    # reset cached counts for restaurants with reviews only
    ids = Set.new
    Review.all.each {|c| ids << c.restaurant_id}
    ids.each do |restaurant_id|
      Restaurant.reset_counters(restaurant_id, :reviews)
    end
  end
  def self.down
    remove_column :restaurants, :reviews_count
  end
end
