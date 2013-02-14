class Panel::UsersController < ApplicationController
  before_filter :load_user, :except=>[:index]
  def index
    @users = User.all
  end

  def show
  end

  def get_role
  	role.try(:name)
  end

  def add_role
    role = Role.find_by_name params[:get_role]
    if role
      if @user.roles.include?(role)
        flash[:error]= I18n.t("panel.roles.exists")
      else
       @user.roles.push role
       flash[:success]= I18n.t("panel.roles.exists")
      end 
    end
    redisplay_roles
  end

  def delete_role
    @user.roles.delete(Role.find params[:role])
    flash[:success]= I18n.t("panel.roles.exists")
    redisplay_roles
  end

  private

  def load_user
    @user = User.find params[:id]
  end

  def redisplay_roles
    respond_to do |format|
      format.html { redirect_to [:panel, @user] }
      format.js { render :redisplay_roles }
    end
  end
end