class GearsController < ApplicationController
  load_and_authorize_resource

  before_action :set_gear, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @gears = Gear.all
    respond_with(@gears)
  end

  def show
    respond_with(@gear)
  end

  def new
    @gear = Gear.new( alpha_code: params[:alpha_code], fishery_id: params[:fishery_id] )
    respond_with(@gear)
  end

  def edit
  end

  def create
    @gear = Gear.new(gear_params)
    @gear.save
    respond_with @gear, location: -> { after_save_path_for(@gear) }
  end

  def update
    @gear.update(gear_params)
    respond_with @gear, location: -> { after_save_path_for(@gear) }
  end

  def destroy
    @gear.destroy
    respond_with(@gear)
  end

  private
  
  def set_gear
    @gear = Gear.find(params[:id])
  end

  def gear_params
    params.require(:gear).permit(
      :alpha_code, 
      :cat_eng, 
      :cat_ind, 
      :fao_code, 
      :name, 
      :num_code, 
      :sub_cat_eng, 
      :sub_cat_ind, 
      :type_eng, 
      :type_ind,
      :fishery_id
      )
  end

  def after_save_path_for(resource)
    if params[:gear][:fishery_id].present?
      fishery = Fishery.find( params[:gear][:fishery_id] )
      fishery.used_gears.push resource
      fishery_path(params[:gear][:fishery_id])
    else
      gear_path(resource)
    end
  end

end


