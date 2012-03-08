class DashboardController < ApplicationController
  def index
    @sports = Sport.scoped_by_university_id(current_university.id)
    @athletes = Athlete.scoped_by_university_id(current_university.id)
    @issues = Issue.scoped_by_university_id(current_university.id)
  end
end
