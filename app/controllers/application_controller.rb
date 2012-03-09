class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def authenticate_inviter!
    # This is a hack
    if current_user
      redirect_to root_path unless current_user.admin?
      @current_inviter = current_user
    else
      authenticate_user!(force: true)
    end
  end
  
  def current_university
    current_user.university
  end
  helper_method :current_university
end
