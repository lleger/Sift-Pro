module ApplicationHelper
  # Helpers to make Devise play nicely
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def current_class(page)
    " class='active'" if controller.controller_name == page
  end
  
  def static_current_page(page)
    " class='active'" if current_page?(page)
  end
end
