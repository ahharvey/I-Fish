class OfficesController < ApplicationController
  load_and_authorize_resource

  #before_action :set_office, only: [:show, :edit, :update, :destroy, :add_admin]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @offices = @offices.default.page(params[:page])
    respond_to do |format|
      format.html
      format.js
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"offices-#{Date.current}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @office = Office.new(office_params)
    respond_to do |format|
      if @office.save
        format.html { redirect_to @office, notice: t('.notice') }
        format.json { render :show, status: :created, location: @office }
      else
        format.html { render :new }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to @office, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @office }
      else
        format.html { render :edit }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @office.destroy
    respond_to do |format|
      format.html { redirect_to offices_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  def crop
    @office = Office.find(params[:id])
    render :crop
  end

  def add_admin
    admin = Admin.find_by_email params[:get_admin]
    if admin
      if @office.admins.include?(admin)
        flash[:alert]= I18n.t("offices.admins.exists")
      else
       @office.admins.push admin
       flash[:success]= I18n.t("offices.admins.created")
      end
      redisplay_admins
    else
      email = params[:get_admin]
      name  = email[0,email.index('@')]
      Admin.invite!({ email: email, name: name, office_id: @office.id, approved: true }, current_admin)
      flash[:success]= I18n.t("offices.admins.invited", office: @office.name )
      redisplay_admins
    end

  end

  def delete_admin
    admin = Admin.find params[:admin]
    admin.update_attribute( :office_id, "")
    flash[:success]= I18n.t("offices.admins.removed")
    redisplay_admins
  end

  private

  def set_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(
      :name,
      :district_id
      )
  end

  def after_save_path_for(resource)
    if params[:office][:avatar].present?
      crop_office_path(resource)
    elsif params[:office][:fishery_id].present?
      fishery = Fishery.find( params[:office][:fishery_id] )
      fishery.member_offices.push resource
      fishery_path(params[:office][:fishery_id])
    else
      root_path
      #company_path(resource)
    end
  end

  def redisplay_admins
    respond_to do |format|
      format.html { redirect_to @office }
      format.js { render :redisplay_admins }
    end
  end

end
