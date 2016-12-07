class Memberships::AdminsController < ApplicationController
  def create
    @admin = Admin.find_by_email admin_params[:email]
    fetch_parent
    if @admin && @object
      name = @admin.name  if      @admin.name.present?
      name = @admin.email unless  @admin.name.present?
      if @object.admins.include?(@admin)
        flash[:notice]= I18n.t("offices.admins.create.notice", admin: name, office: @object.name)
      else
       @object.admins.push @admin
       flash[:success]= I18n.t("offices.admins.create.success", admin: name, office: @object.name)
      end
    elsif admin_params[:email].present? && @object
      email = admin_params[:email]
      name  = email[0,email.index('@')]

      @admin = Admin.invite!({ email: email, name: name, office_id: @object.id, approved: true }, current_admin)

      flash[:alert]= I18n.t("offices.admins.create.alert", admin: email, office: @object.name)
    else
      @admin = nil
      flash[:error]= I18n.t("offices.admins.create.error")
    end

    respond_to do |format|
      format.html { redirect_to @object }
      format.js { render 'admins/redisplay_admins' }
    end
  end


  def destroy
    @admin = Admin.find params[:id]
    fetch_parent

    @admin.update_attribute( :office_id, nil )

    respond_to do |format|
      format.html { redirect_to @object, notice: t('offices.admins.destroy.notice', admin: @admin.name, office: @object.name ) }
      format.js { render :redisplay_admins }
    end

  end

private
  def fetch_parent
    if klass = [Office].detect { |k| params["#{k.name.underscore}_id"]}
      @object = klass.find( params["#{klass.name.underscore}_id"] )
    else
      @object = nil
    end
  end

  def admin_params
    params.require(:admin).permit(
      :email
      )
  end
end
