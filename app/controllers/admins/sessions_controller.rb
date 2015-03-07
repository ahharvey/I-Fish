class Admins::SessionsController < Devise::SessionsController
  layout "signin"

  protected


    def after_sign_in_path_for(resource)
      if resource.avatar? && resource.name?

        flash[:notice] =  I18n.t("supervisor.unapproved.team")  if resource.team_members.where(approved: false)
        flash[:alert] = I18n.t("supervisor.unapproved.survey") if resource.supervised_surveys.where(approved: false)
        stored_location_for(resource) || root_path

      else
        welcome_admin_path(resource)
      end
    end

end


