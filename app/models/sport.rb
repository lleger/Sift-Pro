class Sport < ActiveRecord::Base
  belongs_to :university
  has_many :users
  
  validates :name, :university, presence: true
end
