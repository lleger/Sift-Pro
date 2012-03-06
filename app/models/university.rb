class University < ActiveRecord::Base
  has_many :sports
  has_many :athletes
end
