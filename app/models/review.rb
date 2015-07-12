class Review < ActiveRecord::Base
  validates :restaurant, presence: true
  belongs_to :restaurant
  belongs_to :user
end
