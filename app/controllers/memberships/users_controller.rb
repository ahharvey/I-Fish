class Memberships::UsersController < ApplicationController
  def create
    @user = User.find_by_email user_params[:email]
    fetch_parent
    if @user && @object
      name = @user.name if @user.name.present?
      name = @user.email unless @user.name.present?
      if @object.users.include?(@user)
        flash[:notice]= I18n.t("companies.users.create.notice", user: name, company: @object.name)
      else
       @object.company_positions.create(user_id: @user.id, status: 'active')
       flash[:success]= I18n.t("companies.users.create.success", user: name, company: @object.name)
      end
    elsif user_params[:email].present? && @object
      email = user_params[:email]
      name  = email[0,email.index('@')]

      @user = User.new( email: email, name: name)
      @user.company_positions.build( company_id: @object.id, status: 'active' )
      @user.invite!( @currently_signed_in )

      flash[:alert]= I18n.t("companies.users.create.alert", user: email, company: @object.name)
    else
      @user = nil
      @object = nil unless @object.present?
      flash[:error]= I18n.t("companies.users.create.error")
    end

    respond_to do |format|
      format.html { redirect_to @object }
      format.js { render :redisplay_users }
    end
  end

  def destroy
    @membership = CompanyPosition.find(params[:id])
    company = @membership.company
    name = @membership.user.name if @membership.user.name.present?
    name = @membership.user.email unless @membership.user.name.present?
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to company, notice: t('companies.users.destroy.notice', user: name, company: company.name ) }
      format.js { render :redisplay_users }
    end
  end

private
  def fetch_parent
    if klass = [Company].detect { |k| params["#{k.name.underscore}_id"]}
      @object = klass.find( params["#{klass.name.underscore}_id"] )
    else
      @object = nil
    end
  end

  def user_params
    params.require(:user).permit(
      :email
      )
  end
end
