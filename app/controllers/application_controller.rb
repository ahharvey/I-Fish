class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :authenticate!

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

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  

  private
  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end
end