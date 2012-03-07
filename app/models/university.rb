class University < ActiveRecord::Base
  has_many :sports
  has_many :athletes
  has_many :issues
  
  validates :name, :location, presence: true
end
