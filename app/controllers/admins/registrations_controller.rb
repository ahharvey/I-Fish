class Admins::RegistrationsController < Devise::RegistrationsController
  layout "signin"


  def avatar
    @admin = current_admin
    render :avatar
  end

  def crop
    @admin = current_admin
    render :crop
  end

  def settings
    @admin = current_admin
    render :settings
  end

  def security
    @admin = current_admin
    render :security
  end

  def welcome
    @admin = current_admin
    render :welcome
  end

  protected

    def after_sign_up_path_for(resource)
      flash.keep[:alert] = "Approval sent"
      new_admin_session_path
    end

    def after_inactive_sign_up_path_for(resource)
      root_path
    end

    def after_update_path_for(resource)
      if resource.avatar? == false
        admin_avatar_path
      elsif params[:admin][:avatar].present?
        admin_crop_path
      else
        root_path
      end
    end

end
