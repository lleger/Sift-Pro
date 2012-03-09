class Issue < ActiveRecord::Base
  belongs_to :athlete, :class_name => "User", :foreign_key => "athlete_id"
  belongs_to :admin, :class_name => "User", :foreign_key => "admin_id"
  belongs_to :university
  
  scope :open, where("response is null")
  scope :closed, where("response is not null")
  scope :rejected, where("response is not null and approved is false")
  scope :this_week, lambda { where(created_at: 7.days.ago..Time.now) }
  scope :today, lambda { where(created_at: Time.now.midnight..Time.now) }
  
  def status
    "approved" if approved?
    if !approved? && response.blank?
      "pending"
    else
      "rejected"
    end
  end
end
