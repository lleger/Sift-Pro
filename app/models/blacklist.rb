class Blacklist
  def self.discriminatory
    ["bitch", "bastard", "beaner", "nigger"]
  end
  
  def self.profane
    ["fuck", "damn", "bastard", "shit"]
  end
  
  def self.sexual
    ["cunt", "ax wound", "blow job", "cock", "pussy"]
  end
  
  def self.all
    discriminatory + profane + sexual
  end
end