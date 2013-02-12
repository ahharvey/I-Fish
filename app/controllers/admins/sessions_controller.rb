class Admins::SessionsController < Devise::SessionsController


  protected


    def after_sign_in_path_for(resource)
      if resource.avatar? == false
        admin_avatar_path
      else
        stored_location_for(resource) || root_path
      end
    end

end
