class Users::RegistrationsController < Devise::RegistrationsController


  def avatar
    @user = current_user
    render :avatar
  end

  def crop
    @user = current_user
    render :crop
  end

  def settings
    @user = current_user
    render :settings
  end

  def security
    @user = current_user
    render :security
  end

  def welcome
    @user = current_user
    render :welcome
  end

  protected

    def after_sign_up_path_for(resource)
      new_user_session_path
    end

    def after_inactive_sign_up_path_for(resource)
      root_path
    end

    def after_update_path_for(resource)
      if resource.avatar? == false
        user_avatar_path
      elsif params[:user][:avatar].present?
        user_crop_path
      else
        user_path(resource)
      end
    end

end
