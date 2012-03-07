class Athlete < ActiveRecord::Base
  belongs_to :university
  belongs_to :sport
  has_many :issues
  
  validates :name, :email, :sport, :university, presence: true
end
