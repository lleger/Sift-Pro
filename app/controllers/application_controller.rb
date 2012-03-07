class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_university
    current_user.university
  end
  helper_method :current_user
end
