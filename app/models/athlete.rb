class Athlete < ActiveRecord::Base
  belongs_to :university
  belongs_to :sport
end
