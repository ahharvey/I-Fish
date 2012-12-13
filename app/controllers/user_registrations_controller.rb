class UserRegistrationsController < Devise::RegistrationsController


  protected

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_update_path_for(resource)
    user_crop_path
  end


end
