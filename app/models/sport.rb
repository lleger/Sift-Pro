class Sport < ActiveRecord::Base
  belongs_to :university
  has_many :athletes
end
