class Users::RegistrationsController < Devise::RegistrationsController
  layout "signin"

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

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
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
        set_flash_message :notice, :add_avatar
        user_avatar_path
      elsif params[:user][:avatar].present?
        user_crop_path
      else
        user_path(resource)
      end
    end

    def needs_password?(user, params)
      if params[:user].present?
        user.email != params[:user][:email] ||
          params[:user][:password].present?
      end
    end

end
