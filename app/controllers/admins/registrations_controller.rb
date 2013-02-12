class Admins::RegistrationsController < Devise::RegistrationsController


  protected

  def after_sign_up_path_for(resource)
    new_admin_session_path
  end

  def after_inactive_sign_up_path_for(resource)
    new_admin_session_path
  end

  def after_update_path_for(resource)
    admin_crop_path
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || welcome_path
  end

end
