class Admins::RegistrationsController < Devise::RegistrationsController
  layout "signin"

  def update
    @admin = Admin.find(current_admin.id)

    successfully_updated = if needs_password?(@admin, params)
      @admin.update_with_password(account_update_params)
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:admin].delete(:current_password)
      @admin.update_without_password(account_update_params)
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
      flash.keep[:ganalytics] = "goals/admin_registered"
      welcome_admin_path(resource)
    end

    def after_inactive_sign_up_path_for(resource)
      root_path
    end

    def after_update_path_for(resource)
      admin_path(resource)
    end

    def needs_password?(admin, params)
      if params[:admin].present?
        admin.email != params[:admin][:email] ||
          params[:admin][:password].present?
      end
    end

    

end
