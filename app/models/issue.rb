class Issue < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :university
  
  def status
    "approved" if approved?
    if !approved? && response.blank?
      "pending"
    else
      "rejected"
    end
  end
end
