class VesselsController < ApplicationController
  load_and_authorize_resource

  before_action :set_vessel, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @vessels = Vessel.all
    respond_with(@vessels)
  end

  def show
    respond_with(@vessel)
  end

  def new
    @vessel = Vessel.new(company_id: params[:company_id], ap2hi_ref: params[:ap2hi_ref], return_to: params[:company_id])
    respond_with(@vessel)
  end

  def edit
  end

  def create
    @vessel = Vessel.new(vessel_params)
    track_activity @vessel if @vessel.save
    respond_with @vessel, location: -> { after_save_path_for(@vessel) }
  end

  def update
    track_activity @vessel if @vessel.update(vessel_params)
    respond_with @vessel, location: -> { after_save_path_for(@vessel) }
  end

  def destroy
    track_activity @vessel if @vessel.destroy
    respond_with(@vessel)
  end

  private
  
  def set_vessel
    @vessel = Vessel.find(params[:id])
  end

  def vessel_params
    params.require(:vessel).permit(
      :name, 
      :vessel_type_id, 
      :gear_id, 
      :flag_state, 
      :year_built, 
      :length, 
      :tonnage, 
      :imo_number, 
      :shark_policy, 
      :iuu_list, 
      :code_of_conduct, 
      :company_id,
      :ap2hi_ref,
      :issf_ref,
      :crew,
      :hooks,
      :captain,
      :owner,
      :sipi_number,
      :sipi_expiry,
      :siup_number,
      :issf_ref_requested,
      :name_changed,
      :flag_state_changed,
      :radio,
      :relationship_type,
      :formatted_sipi_expiry
      )
  end


  def after_save_path_for(resource)
    if params[:vessel][:return_to].present?
      company_path(params[:vessel][:return_to])
    else
      vessel_path(resource)
    end
  end

end

