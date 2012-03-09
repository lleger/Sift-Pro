class Blacklist < ActiveRecord::Base
  belongs_to :university
  belongs_to :user
  
  validates :word, presence: true
  
  def self.default
    DEFAULT_BLACKLIST
  end
  
  def self.find_offensive_words(tweet)
    offensive_words = Array.new
    all_with_default.each do |naughty|
      offensive_words << naughty if tweet =~ Regexp.new(naughty)
    end
    offensive_words
  end
  
  def self.all_with_default
    default + all.map(&:word).map(&:downcase)
  end
end