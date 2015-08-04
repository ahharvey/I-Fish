class Users::SessionsController < Devise::SessionsController
	layout "signin"

  protected


    def after_sign_in_path_for(resource)
      if resource.avatar? == false
        edit_user_path(resource)
      else
        stored_location_for(resource) || root_path
      end
    end

end
