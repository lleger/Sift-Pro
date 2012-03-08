class Blacklist < ActiveRecord::Base
  belongs_to :university
  belongs_to :user
  
  validates :word, presence: true
  
  def self.discriminatory
    ["bitch", "bastard", "beaner", "nigger"]
  end
  
  def self.profane
    ["fuck", "damn", "bastard", "shit"]
  end
  
  def self.sexual
    ["cunt", "ax wound", "blow job", "cock", "pussy"]
  end
  
  def self.default
    discriminatory + profane + sexual
  end
  
  def self.all_with_default
    default + all.map(&:word).map(&:downcase)
  end
end