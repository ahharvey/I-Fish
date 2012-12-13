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
    content_tag(:i, "", class: 'icon-upload-alt icon-white')
  end

  def edit_profile_icon
    content_tag(:i, "", class: 'icon-cogs icon-white')
  end

  def logout_icon
    content_tag(:i, "", class: 'icon-signout icon-white')
  end

  def show_icon
    content_tag(:i, "", class: 'icon-eye-open')
  end

  def edit_icon
    content_tag(:i, "", class: 'icon-edit')
  end

  def destroy_icon
    content_tag(:i, "", class: 'icon-trash')
  end
  
end
