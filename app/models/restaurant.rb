class Restaurant < ActiveRecord::Base
  validates :name, presence: true
  has_many :reviews
  
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tags
end
