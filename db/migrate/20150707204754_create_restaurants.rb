class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :website
      t.string :address
      t.string :district
      t.string :image
      t.string :price
      t.timestamps null: false
    end
  end
end
