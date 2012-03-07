class Issue < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :university
  
  scope :open, where("response is null")
  scope :closed, where("response is not null")
  scope :rejected, where("response is not null and approved is false")
  
  def status
    "approved" if approved?
    if !approved? && response.blank?
      "pending"
    else
      "rejected"
    end
  end
end
