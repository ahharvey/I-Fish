module ApplicationHelper
  def is_active?(page_name)
    "active" if current_page?(page_name)
  end
  
  def title(page_title, show_title = true)
    page_title = page_title.join(' ') if page_title.respond_to? :join
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def twitterized_type(type)
    case type
    when :alert
      "warning"
    when :error
      "error"
    when :notice
      "info"
    when :success
      "success"
    else
      type.to_s
    end
  end
  
  def upload_icon
    content_tag(:i, "", :class=>'icon-upload icon-white')
  end
  
end
