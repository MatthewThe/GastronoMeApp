class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :restaurant, index: true
      t.belongs_to :user, index: true
      t.date :date
      t.text :review
      t.string :with
      t.float :rating_atmosphere
      t.float :rating_service
      t.float :rating_food
      t.float :rating_location
      t.float :rating_overall
      t.timestamps null: false
    end
  end
end
