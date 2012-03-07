module IssuesHelper
  def status_and_icon(status)
    if status == "approved"
      css_class = "icon-ok-sign"
    elsif status == "pending"
      css_class = "icon-question-sign"
    else
      css_class = "icon-remove-sign"
    end
    
    content_tag(:i, nil, class: css_class) + content_tag(:span, status)
  end
end
