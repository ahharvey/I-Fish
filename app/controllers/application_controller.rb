require "application_responder"

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
  before_filter :set_locale
  #before_filter :authenticate!
  before_filter :set_currently_signed_in
  after_filter :flash_to_headers
  # Override default Cancan current ability to fetch a specific one
  def current_ability
    @current_ability ||= case
      when current_user
        Ability.new(current_user)
      when current_admin
        Ability.new(current_admin)
      else Ability.new(User.new) 
      end
  end

  # Custom authenticate to handle current user or admin
  def authenticate!
    if admin_signed_in?
      authenticate_admin!
      @currently_signed_in ||= current_admin
    else
      authenticate_user!
      @currently_signed_in ||= current_user
    end
  end

  def set_currently_signed_in
    if admin_signed_in?
      @currently_signed_in ||= current_admin
    else
      @currently_signed_in ||= current_user
    end
  end

  def user_for_paper_trail
    admin_signed_in? ? current_admin.id : 'Guest'  # or whatever
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def track_activity(trackable, action = params[:action])
    @currently_signed_in.activities.create! action: action, trackable: trackable 
  end


  protected

  def configure_permitted_parameters
    if resource_class == Admin
      devise_parameter_sanitizer.for(:sign_up) << [:name, :office_id]
      devise_parameter_sanitizer.for(:invite) << [:office_id, :approved]
      devise_parameter_sanitizer.for(:accept_invitation) << [:name]
    end

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
    [:alert, :error, :notice, :success].each do |type|
      return flash[type] unless flash[type].blank?
    end
  end

  def flash_type
    [:alert, :error, :notice, :success].each do |type|
      return type unless flash[type].blank?
    end
  end

    
end