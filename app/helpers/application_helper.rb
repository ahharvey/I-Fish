module ApplicationHelper
  def is_active?(page_name)
    "active" if current_page?(page_name)
  end

  def title(page_title, show_title = true)
    page_title = page_title.join(' ') if page_title.respond_to? :join
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def subtitle(page_subtitle, show_subtitle = true)
    page_subtitle = page_subtitle.join(' ') if page_subtitle.respond_to? :join
    content_for(:subtitle) { h(page_subtitle.to_s) }
    @show_subtitle = show_subtitle
  end

  def twitterized_type(type)
    case type.to_s
    when 'alert'
      "warning"
    when 'error'
      'danger'
    when 'notice'
      "info"
    when 'success'
      "success"
    else
      type.to_s
    end
  end

  def human_bool(boolean)
    boolean ? 'Yes' : 'No'
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def current_url(new_params)
    url_for params.permit(:controller, :action, :id, :locale).merge( new_params.slice(:format) )
  end

  def fa_home
    "home"
  end

  def fa_submit
    "cloud-upload"
  end

  def fa_import
    "upload"
  end

  def fa_approve
    "check"
  end

  def fa_reports
    "line-chart"
  end

  def fa_protocols
    "download"
  end

  def fa_settings
    "cog"
  end

  def fa_profile
    "user"
  end

  def fa_edit_profile
    "cogs"
  end

  def fa_password
    "key"
  end

  def fa_avatar
    "user"
  end

  def fa_logout
    "sign-out"
  end

  def fa_integrate
    "exchange"
  end

  def fa_new
    "plus"
  end

  def fa_word
    "file-word-o"
  end

  def fa_excel
    "file-excel-o"
  end

  def fa_pdf
    "file-pdf-o"
  end

  def fa_image
    "file-image-o"
  end

  def fa_danger
    'minus-circle'
  end

  def fa_warning
    'exclamation-triangle'
  end

  def show_icon
    icon 'eye'
  end

  def edit_icon
    icon 'edit'
  end

  def destroy_icon
    icon 'trash'
  end

  def add_icon
    icon 'plus'
  end

  def email_icon
    icon 'envelope-o'
  end

  def addressbook_icon
    icon 'book'
  end

  def remove_icon
    icon 'remove'
  end

  def fa_true
    'check-square-o'
  end

  def fa_false
    'square-o'
  end





  def flag_en
    image_tag("blank.gif", class: "flag flag-gb", alt: "English")
  end

  def flag_id
    image_tag("blank.gif", class: "flag flag-id", alt: "Indonesian")
  end


  def up_arrow
    icon 'arrow-up', "", class: 'success'
  end

  def down_arrow
    icon 'arrow-down', "", class: 'danger'
  end




          def upload_icon_nav
            content_tag(:i, "", class: 'icon- icon-white icon-2x')
          end

          def upload_icon
            content_tag(:i, "", class: 'icon-cloud-upload icon-white')
          end

          def upload_icon_large
            content_tag(:i, "", class: 'icon-cloud-upload icon-white icon-large')
          end

          def approve_icon
            content_tag(:i, "", class: 'icon-ok icon-white icon-2x')
          end

          def report_icon
            content_tag(:i, "", class: 'icon-bar-chart icon-white icon-2x')
          end

          def download_icon_nav
            content_tag(:i, "", class: 'icon-cloud-download icon-white icon-2x')
          end



          def edit_profile_icon
            content_tag(:i, "", class: 'icon-cogs')
          end

          def settings_icon
            content_tag(:i, "", class: 'icon-cog icon-white icon-2x')
          end

          def profile_icon
            content_tag(:i, "", class: 'icon-user icon-white icon-2x')
          end

          def security_icon
            content_tag(:i, "", class: 'icon-key')
          end

          def avatar_icon
            content_tag(:i, "", class: 'icon-user')
          end

          def logout_icon
            content_tag(:i, "", class: 'icon-signout')
          end



  def excel_icon
    icon 'table'
  end

  def doc_icon
    icon 'file'
  end





  def excel_image
    image_tag("excel.png", class: "", alt: "Excel", width: 16)
  end

  def pdf_image
    image_tag("pdf.png", class: "", alt: "PDF", width: 16)
  end

  def approve_icon2
    content_tag(:i, "", class: 'icon-ok icon-white icon-large')
  end

  def unapprove_icon2
    content_tag(:i, "", class: 'icon-remove icon-white icon-large')
  end

  # builds link for nested forms
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-success btn-block", data: {id: id, fields: fields.gsub("\n", "")})
  end



end
