class Panel::AdminsController < ApplicationController
  before_filter :load_admin, :except=>[:index]

  def index
    @admins = Admin.all
  end

  def show
  end

  def get_role
  	role.try(:name)
  end

  def add_role
    role = Role.find_by_name params[:get_role]
    if role
    	@admin.roles.push role unless @admin.roles.include?(role)
    end
    redisplay_roles
  end

  def delete_role
    @admin.roles.delete(Role.find params[:role])
    redisplay_roles
  end

  private

  def load_admin
    @admin = Admin.find params[:id]
  end

  def redisplay_roles
    respond_to do |format|
      format.html { redirect_to [:panel, @admin] }
      format.js { render :redisplay_roles }
    end
  end
end
