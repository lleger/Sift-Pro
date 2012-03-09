class DashboardController < ApplicationController
  def index
    if current_user.admin?
      @sports = Sport.scoped_by_university_id(current_university.id)
      @athletes = Athlete.scoped_by_university_id(current_university.id)
      @issues = Issue.scoped_by_university_id(current_university.id)
    elsif !current_user.connected_twitter?
      redirect_to authorize_path
    else
      
    end
  end
end
