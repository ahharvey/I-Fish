class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :authenticate!
  after_filter :flash_to_headers
  # Override default Cancan current ability to fetch a specific one
  def current_ability
  	@current_ability ||= case
  	  when current_user
  	  	UserAbility.new(current_user)
  	  when current_admin
  	  	AdminAbility.new(current_admin)
  	  end
  end

  # Custom authenticate to handle current user or admin
  def authenticate!
  	if admin_signed_in?
      authenticate_admin!
      @currently_signed_in = current_admin
    else
  	  authenticate_user!
  	  @currently_signed_in = current_user
  	end
  end

  def user_for_paper_trail
    admin_signed_in? ? current_admin : 'Guest'  # or whatever
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  

  private
  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def self.default_url_options(options = {})
    options.merge({locale: I18n.locale})
  end

  def flash_to_headers
    return unless request.xhr?
    response.headers['X-Message'] = flash_message
    response.headers["X-Message-Type"] = flash_type.to_s

    flash.discard # don't want the flash to appear when you reload page
  end

  def flash_message
    [:error, :warning, :notice].each do |type|
      return flash[type] unless flash[type].blank?
    end
  end

  def flash_type
    [:error, :warning, :notice].each do |type|
      return type unless flash[type].blank?
    end
  end

    
end