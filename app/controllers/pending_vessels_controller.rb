class PendingVesselsController < ApplicationController
  load_and_authorize_resource

  before_action :set_pending_vessel, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :pdf, :except => [ :edit, :new, :update, :create ]

  def index
    @pending_vessels = PendingVessel.all
    respond_with(@pending_vessels)
  end

  def show
    respond_with(@pending_vessel)
  end

  def new
    @pending_vessel = PendingVessel.new(vessel_id: params[:vessel_id])
    respond_with(@pending_vessel)
  end

  def edit
  end

  def create
    @pending_vessel = PendingVessel.new(pending_vessel_params)
    respond_with @pending_vessel, location: -> { after_save_path_for(@pending_vessel) }
  end

  def update
    respond_with @pending_vessel, location: -> { after_save_path_for(@pending_vessel) }
  end

  def destroy
    respond_with(@pending_vessel)
  end

  private
  
  def set_pending_vessel
    @pending_vessel = PendingVessel.find(params[:id])
  end

  def pending_vessel_params
    params.require(:pending_vessel).permit(
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
      :formatted_sipi_expiry,
      :return_to, 
      :material_type, 
      :machine_type, 
      :capacity, 
      :vms, 
      :tracker, 
      :port,
      :vessel_id
      )
  end


  def after_save_path_for(resource)
    vessel_path(resource.vessel_id)
  end

end

