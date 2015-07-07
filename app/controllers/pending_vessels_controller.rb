class PendingVesselsController < ApplicationController
  load_and_authorize_resource

  before_action :set_pending_vessel, only: [:show, :edit, :update, :destroy, :accept]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :pdf, :except => [ :edit, :new, :update, :create ]

  def index
    @pending_vessels = PendingVessel.pending
    respond_with(@pending_vessels)
  end

  def show
    respond_with(@pending_vessel)
  end

  def new
    @audit = Audit.find( params[:audit_id] )
    @vessel = @audit.auditable
    @pending_vessel = PendingVessel.new(
      @vessel.auditable_attributes.merge(
        audit_id: @audit.id, 
        admin_id: @audit.admin_id, 
        vessel_id: @audit.auditable_id
        )
      )
    respond_with(@pending_vessel)
  end

  def edit
  end

  def create

    @pending_vessel = PendingVessel.create( pending_vessel_params )
    @pending_vessel.pending!
    @pending_vessel.save
    respond_with @pending_vessel, location: -> { after_save_path_for(@pending_vessel) }
  end

  def update
    @pending_vessel.update(pending_vessel_params )
    @pending_vessel.pending!
    respond_with @pending_vessel, location: -> { after_save_path_for(@pending_vessel) }
  end

  def destroy
    @pending_vessel.destroy
    respond_with(@pending_vessel)
  end

  def approve
    @pending_vessel.approve!
    @pending_vessel.vessel.audits.new(admin_id: @currently_signed_in.id).reviewed!
    @pending_vessel.save 
    respond_with @pending_vessel, location: -> { vessel_path(@pending_vessel.vessel) }
  end

  def reject
    @pending_vessel.reject!
    @pending_vessel.save 
    respond_with @pending_vessel, location: -> { vessel_path(@pending_vessel.vessel) }
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
      :vessel_id,
      :bait_capacity,
      :location_built, 
      :fish_capacity,
      :audit_id,
      :admin_id,
      :operational_type
      )
  end


  def after_save_path_for(resource)
    vessel_path(resource.vessel_id)
  end

end

