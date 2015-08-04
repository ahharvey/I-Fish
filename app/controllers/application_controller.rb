require "application_responder"

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  self.responder = ApplicationResponder
  respond_to :html

  rescue_from CanCan::AccessDenied do |exception| #, with: :access_denied
    if @currently_signed_in.nil?
      session[:next] = request.fullpath
      puts session[:next]
      redirect_to new_user_session_url, alert: "You must log in to continue."
    else
      #render :file => "#{Rails.root}/public/403.html", :status => 403
      if request.env["HTTP_REFERER"].present?
        redirect_to :back, alert: exception.message
      else
        redirect_to root_url, alert: exception.message
      end
    end
  end

  # in production redirects to 404 if url does not exist
  # in other environments displays real exceptions
  unless Rails.application.config.consider_all_requests_local 
    rescue_from ActionController::RoutingError, with: -> { render_404  }
  end

  #add_flash_types :error, :success, :info

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


  def track_activity(trackable, action = params[:action])
    @currently_signed_in.activities.create! action: action, trackable: trackable 
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      Admin.exists?(access_token: token)
    end
  end

  before_filter :staff_dashboard if admin_signed_in? 
  def staff_dashboard
    pendingVessels      = PendingVessel.pending.size
    pendingUnloadings   = Unloading.where(vessel_id: current_admin.managed_vessels.map(&:id), review_state: 'pending' ).size
    pendingBaitLoadings = BaitLoading.where(vessel_id: current_admin.managed_vessels.map(&:id), review_state: 'pending' ).size
    @staff_dashboard_pending = pendingVessels + pendingUnloadings + pendingBaitLoadings
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
    response.headers["X-Message-Type"] = twitterized_type( flash_type )

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


    
end