class Blacklist < ActiveRecord::Base
  belongs_to :university
  belongs_to :user
  
  validates :word, presence: true
  
  def self.default
    DEFAULT_BLACKLIST
  end
  
  def self.all_with_default
    default + all.map(&:word).map(&:downcase)
  end
end