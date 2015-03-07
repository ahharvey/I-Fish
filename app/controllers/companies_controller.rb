#class CompaniesController < InheritedResources::Base#

#  def create
#    create! do |format|
#      unless @company.errors.empty? # failure
#        format.html { redirect_to after_save_path_for(@company) }
#      end
#    end
#  end#

#  def update
#    update! do |format|
#      unless @company.errors.empty? # failure
#        format.html { redirect_to after_save_path_for(@company) }
#      end
#    end
#  end#

#  #

#  private#

#    def company_params
#      params.require(:company).permit()
#    end#

#    
#end




class CompaniesController < ApplicationController
  load_and_authorize_resource

  before_action :set_company, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @companies = Company.all
    respond_with(@companies)
  end

  def show
    respond_with(@company)
  end

  def new
    @company = Company.new(name: params[:name], fishery_id: params[:fishery_id] )
    respond_with(@company)
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    @company.save
    

    respond_with @company, location: -> { after_save_path_for(@company) }
  end

  def update
    @company.update(company_params)
    respond_with @company, location: -> { after_save_path_for(@company) }
  end

  def destroy
    @company.destroy
    respond_with(@company)
  end

  def crop
    @company = Company.find(params[:id])
    render :crop
  end

  def add_vessel
    vessel = Vessel.find_by_ap2hi_ref params[:get_vessel]
    if vessel
      if @company.vessels.include?(vessel)
        flash[:alert]= I18n.t("companies.vessels.exists")
      else
       @company.vessels.push vessel
       flash[:success]= I18n.t("fisheries.vessels.created")
      end 
      redisplay_vessels
    else
      render js: "window.location = #{new_vessel_path(company_id: params[:id], ap2hi_ref: params[:get_vessel]).to_json}"
    end
    
  end

  def delete_vessel
    vessel = Vessel.find params[:vessel]
    vessel.update_attribute(company_id: "")
    flash[:success]= I18n.t("companies.vessels.removed")
    redisplay_vessels
  end

  private
  
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(
      :name, 
      :shark_policy, 
      :iuu_list, 
      :code_of_conduct, 
      :member,
      :avatar, 
      :crop_x, 
      :crop_y, 
      :crop_w, 
      :crop_h,
      :fishery_id
      )
  end

  def after_save_path_for(resource)
    if params[:company][:avatar].present?
      crop_company_path(resource)
    elsif params[:company][:fishery_id].present?
      fishery = Fishery.find( params[:company][:fishery_id] )
      fishery.member_companies.push resource
      fishery_path(params[:company][:fishery_id])
    else
      root_path
      #company_path(resource)
    end
  end

  def redisplay_vessels
    respond_to do |format|
      format.html { redirect_to @company }
      format.js { render :redisplay_vessels }
    end
  end

end
