class CompanyPresenter < BasePresenter
  presents :company

  def member
    handle_none company.member do
      if company.member?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

  def code_of_conduct
    handle_none company.code_of_conduct do
      if company.code_of_conduct?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

  def shark_policy
    handle_none company.shark_policy do
      if company.shark_policy?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

  def iuu_list
    handle_none company.iuu_list do
      if company.iuu_list?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

#  def avatar
#    if company.avatar?
#      image_tag company.avatar_url(:thumb), title: company.name, class: 'img-circle', style: 'width:30px;height:30px;'
#    else
#      content_tag :div,  class: 'img-circle avatar', style: 'width:30px;height:30px;' do
#        if company.code.present?
#          company.code.capitalize
#        else
#          "#{company.name.split.last.first.capitalize}#{company.name.split.last.first.capitalize}"
#        end
#      end
#    end
#  end#

#  def linked_avatar
#    link_to company do
#      company.avatar
#    end
#    link_to company_path(company), title: company.name, class: classes, style: styles do
#      avatar(
#        image_class: options[:image_class],
#        image_styles: options[:image_styles],
#        size: options[:size]
#        )
#    end
#  end

  def avatar args = {}

    options = {
        image_class: nil,
        image_styles: nil,
        size: 50,
      }.merge(args)

    # sets equal height and width as we want a circle
    avatar_size   = build_style_size options[:size]
    text_size     = build_style_text options[:size]

    # builds a string of classes and styles
    classes       = build_string_from_attributes 'img-circle', options[:image_class]
    styles        = build_string_from_attributes avatar_size, options[:image_styles]

    # builds the image or
    # fallsback to initials
    if company.avatar?
      image_tag company.avatar.large.url, alt: company.name, class: classes, style: styles, itemprop: 'image'
    else
      avatar_not_set classes, styles, avatar_size, text_size, options[:size], company.name
    end

  end

  def linked_avatar args = {}

    options = {
        link_class:   nil,
        image_class:  nil,
        link_styles:  nil,
        image_styles: nil,
        size: 50,
      }.merge(args)

    classes = options[:link_class]
    styles  = options[:link_styles]

    link_to company_path(company), title: company.name, class: classes, style: styles do
      avatar(
        image_class: options[:image_class],
        image_styles: options[:image_styles],
        size: options[:size]
        )
    end

  end

  private

  def handle_none(value)
    if value.present?
      yield
    else
      content_tag :span, "--", class: "no-data"
    end
  end

  def build_style_text size
    return nil if size.nil?
    halfsize  = size * 0.5
    text      = "font-size:#{halfsize}px;"
  end

  def avatar_not_set classes, styles, avatar_size, text_size, options_size, name

    # adds avatar-not-set to the classes
    classes = build_string_from_attributes classes, 'avatar'
    styles   = build_string_from_attributes styles, text_size

    # we construct the avatar
    content_tag :div, class: classes, style: styles, title: name do
      company.initials
    end

  end

  def build_style_size size
    width     = "width:#{size.to_s}px;"
    height    = "height:#{size.to_s}px;"
    minwidth  = "min-width:#{size.to_s}px;"
    minheight = "min-height:#{size.to_s}px;"
    width + height + minwidth + minheight
  end

  def build_string_from_attributes *args
    args.reject(&:nil?).reject(&:empty?).join(' ')
  end

end
