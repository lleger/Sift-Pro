class University < ActiveRecord::Base
  has_many :sports
  has_many :athletes
  
  validates :name, :location, presence: true
end
