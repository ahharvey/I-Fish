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

  def update
    @admin = Admin.find(current_admin.id)

    successfully_updated = if needs_password?(@admin, params)
      @admin.update_with_password(params[:admin])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:admin].delete(:current_password)
      @admin.update_without_password(params[:admin])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @admin, :bypass => true
      redirect_to after_update_path_for(@admin)
    else
      render "edit"
    end
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
        set_flash_message :notice, :add_avatar
        admin_avatar_path
      elsif params[:admin][:avatar].present?
        admin_crop_path
      else
        root_path
      end
    end

    def needs_password?(admin, params)
      if params[:admin].present?
        admin.email != params[:admin][:email] ||
          params[:admin][:password].present?
      end
    end

end
