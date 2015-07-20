class Restaurant < ActiveRecord::Base
  validates :name, presence: true
  has_many :reviews
  
  geocoded_by :address_plus
  
  def address_plus
    if %w(norrmalm södermalm östermalm vasastan spånga).include? district.downcase
      district_plus = district + ", Stockholm"
    else
      district_plus = district
    end
    [address, district_plus].compact.join(', ')
  end
  after_validation :geocode, :if => lambda {:address_changed? or :district_changed? }
  
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tags
end
