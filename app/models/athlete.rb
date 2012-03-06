class Athlete < ActiveRecord::Base
  belongs_to :university
  belongs_to :sport
  
  validates :name, :email, :sport, presence: true
  
  BLACKLIST = ["damn", "ax wound"]
end
