class Sport < ActiveRecord::Base
  belongs_to :university
  has_many :athletes
  
  validates :name, :university, presence: true
end
