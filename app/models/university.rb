class University < ActiveRecord::Base
  has_many :sports
  has_many :athletes
  has_many :issues
  has_many :users
  
  accepts_nested_attributes_for :users
  
  validates :name, :location, presence: true
end
