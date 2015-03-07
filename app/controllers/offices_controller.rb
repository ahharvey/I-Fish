class OfficesController < ApplicationController
  load_and_authorize_resource

  before_action :set_office, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @offices = Office.all
    respond_with(@offices)
  end

  def show
    respond_with(@office)
  end

  def new
    @office = Office.new(name: params[:name], fishery_id: params[:fishery_id] )
    respond_with(@offcie)
  end

  def edit
  end

  def create
    @office = Office.new(office_params)
    @office.save
    

    respond_with @office, location: -> { after_save_path_for(@office) }
  end

  def update
    @office.update(office_params)
    respond_with @office, location: -> { after_save_path_for(@office) }
  end

  def destroy
    @office.destroy
    respond_with(@office)
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
      flash[:success]= I18n.t("offices.admins.invited")
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
      :district_id, 
      :fishery_id
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
