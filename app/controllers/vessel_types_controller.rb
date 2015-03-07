class VesselTypesController < ApplicationController
  load_and_authorize_resource

  before_action :set_vessel_type, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @vessel_types = VesselType.all
    respond_with(@vessel_types)
  end

  def show
    respond_with(@vessel_type)
  end

  def new
    @vessel_type = VesselType.new
    respond_with(@vessel_type)
  end

  def edit
  end

  def create
    @vessel_type = VesselType.new(vessel_type_params)
    @vessel_type.save
    respond_with @vessel_type, location: -> { after_save_path_for(@vessel_type) }
  end

  def update
    @vessel_type.update(vessel_type_params)
    respond_with @vessel_type, location: -> { after_save_path_for(@vessel_type) }
  end

  def destroy
    @vessel_type.destroy
    respond_with(@vessel_type)
  end

  private
  
  def set_vessel_type
    @vessel_type = VesselType.find(params[:id])
  end

  def vessel_type_params
    params.require(:vessel_type).permit(
      :name, 
      :code
      )
  end

  def after_save_path_for(resource)
    vessel_type_path(resource)
  end

end

