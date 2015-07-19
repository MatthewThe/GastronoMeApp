class Review < ActiveRecord::Base
  validates :restaurant, presence: true
  validates :date, presence: true
  belongs_to :restaurant, :counter_cache => true
  belongs_to :user
end
