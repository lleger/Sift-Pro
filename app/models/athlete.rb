class Athlete < ActiveRecord::Base
  belongs_to :university
  belongs_to :sport
  
  validates :name, :email, :sport, :university, presence: true
end
