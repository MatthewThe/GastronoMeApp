class AddFoodField < ActiveRecord::Migration
  def change
    add_column :reviews, :food, :text
  end
end
