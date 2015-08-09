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

  before_action :set_company, only: [:show, :edit, :update, :destroy, :report]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]
  respond_to :js, only: [:catch_composition, :current_monthly_production, :average_monthly_production, :current_fuel_utilization]

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
      #flash[:success]= I18n.t("fisheries.vessels.created")
    end
    
  end

  def delete_vessel
    vessel = Vessel.find params[:vessel]
    vessel.update_attributes(company_id: "")
    flash[:success]= I18n.t("companies.vessels.removed")
    redisplay_vessels
  end

  def report
    respond_with(@company)
  end
  def current_catch_composition
    @company = Company.find(params[:id])
    @unloadings = @company.unloadings.where( 'unloadings.time_in > ?', Date.today.beginning_of_year)
    @catch = UnloadingCatch.where(unloading_id: @unloadings.map(&:id) ).group(:fish_id).count
    @catch = Hash[@catch.map{|k,v| [Fish.find(k).code,v]}]
    render json: @catch

  end
  def average_catch_composition
    @company = Company.find(params[:id])
    @unloadings = @company.unloadings
    @catch = UnloadingCatch.where(unloading_id: @unloadings.map(&:id) ).group(:fish_id).count
    @catch = Hash[@catch.map{|k,v| [Fish.find(k).code,v]}]
    render json: @catch
  end
  def current_monthly_production
    @company = Company.find(params[:id])
    fishes   = Fish.default
    production = fishes.map{ |fish| 
      { 
        name: fish.code, 
        data: fish.
          unloadings.
          where( vessel_id: @company.vessels.map(&:id), time_in: Date.today.beginning_of_year..Date.today  ).
          group_by_month_of_year(:time_in, format: '%b' ).
          sum(:quantity) 
        }
      }
    production = production.delete_if { |k, v| v.blank? }
    render json: production.chart_json
  end
  def average_monthly_production
    @company = Company.find(params[:id])
    fishes   = Fish.default
    production = fishes.map{ |fish| 
      { 
        name: fish.code, 
        data: fish.
          unloadings.
          where( vessel_id: @company.vessels.map(&:id)  ).
          group_by_month_of_year(:time_in, format: '%b' ).
          sum(:quantity) 
        }
      }
    production = production.delete_if { |k, v| v.blank? }

    render json: production.chart_json
      
  end
  def current_monthly_cpue
    @company = Company.find(params[:id])
    fishes   = Fish.default
    cpue = fishes.map{ |fish| 
      { 
        name: fish.code, 
        data: Unloading.
          where( vessel_id: @company.vessels.map(&:id), time_in: Date.today.beginning_of_year..Date.today  ).
          group_by_month_of_year(:time_in, format: '%b' ).
          average(:cpue) 
        }
      }
    cpue = cpue.delete_if { |k, v| v.blank? }
    render json: cpue.chart_json
  end
  def average_monthly_cpue
    @company = Company.find(params[:id])
    fishes   = Fish.default
    cpue = fishes.map{ |fish| 
      { 
        name: fish.code, 
        data: Unloading.
          where( vessel_id: @company.vessels.map(&:id)  ).
          group_by_month_of_year(:time_in, format: '%b' ).
          average(:cpue) 
        }
      }
    cpue = cpue.delete_if { |k, v| v.blank? }

    render json: cpue.chart_json
  end

  def current_fuel_utilization
    @company = Company.find(params[:id])
    @unloadings = @company.unloadings
    array = [['Fuel', 'Catch']]
    @unloadings.each do |unloading|
      array << [unloading.fuel, unloading.unloading_catches.sum(:quantity)]
    end
    render json: array
  end

  def add_user
    user = User.find_by_email params[:get_user]
    if user
      if @company.users.include?(user)
        flash[:alert]= I18n.t("companies.users.exists")
      else
       @company.company_positions.create(user_id: user.id, status: 'active')
       flash[:success]= I18n.t("companies.users.created")
      end 
      redisplay_users
    else
      email = params[:get_user]
      name  = email[0,email.index('@')]
      User.invite!({ email: email, name: name, company_id: @company.id, approved: true }, current_user)
      flash[:success]= I18n.t("companies.users.invited")
      redisplay_users
    end

  end

  def delete_user
    user = User.find params[:user]
    user.update_attribute( :office_id, "")
    flash[:success]= I18n.t("companies.users.removed")
    redisplay_users
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

  def redisplay_users
    respond_to do |format|
      format.html { redirect_to @company }
      format.js { render :redisplay_users }
    end
  end

end
