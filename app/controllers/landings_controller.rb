class LandingsController < ApplicationController
  load_and_authorize_resource

  before_action :set_landing, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @landings = Landing.all
    respond_with(@landings)
  end

  def show
    respond_with(@landings)
  end

  def new
    @landing = Landing.new
    respond_with(@landing)
  end

  def edit
  end

  def create
    @landing = Landing.new(landing_params)
    @landing.save
    respond_with @landing, location: -> { after_save_path_for(@landing) }
  end

  def update
    @landing.update(landing_params)
    respond_with @landing, location: -> { after_save_path_for(@landing) }
  end

  def destroy
    @landing.destroy
    respond_with(@landing)
  end

  private
  
  def set_landing
    @landing = Landing.find(params[:id])
  end

  def landing_params
    params.require(:landing).permit(
      :boat_size, 
      :crew, 
      :fuel, 
      :gear_id, 
      :quantity, 
      :sail, 
      :time_in, 
      :time_out, 
      :value, 
      :vessel_name, 
      :vessel_ref, 
      :weight, 
      :vessel_type_id,
      :power, 
      :graticule_id, 
      :engine_id, 
      :survey_id, 
      :fish_id, 
      :importing?, 
      :cpue, 
      :row,:ice,
      :conditions,
      :aborted
      )
  end

  def after_save_path_for(resource)
    landing_path(resource)
  end

end

