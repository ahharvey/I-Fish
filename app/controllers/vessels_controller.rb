class VesselsController < ApplicationController
  load_and_authorize_resource

  before_action :set_vessel, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :pdf, :except => [ :edit, :new, :update, :create ]

  def index
    if params[:company_id]
      @vessels = Vessel.where(company_id: params[:company_id] )
      @company = Company.find( params[:company_id])
      sticker_filename = "VesselStickers_#{@company.code}_#{Date.today.strftime("%Y%m%d")}.pdf"
    else
      @vessels = Vessel.all
      sticker_filename = "VesselStickers_#{Date.today.strftime("%Y%m%d")}.pdf"
    end
    respond_with(@vessels) do |format|
      format.pdf do
        pdf = StickerPdf.new(@vessels, view_context)
        send_data pdf.render, filename: 
        sticker_filename,
        type: "application/pdf"
      end
    end
  end

  def show
    @vessels = []
    @vessels << @vessel
    respond_with(@vessel) do |format|
      format.pdf do
        pdf = StickerPdf.new(@vessels)
        send_data pdf.render, filename: 
        "VesselStickers_#{@vessel.ap2hi_ref}_#{Date.today.strftime("%Y%m%d")}.pdf",
        type: "application/pdf"
      end
    end
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

  def generate_stickers
    if params[:company_id]
      @vessels = Vessel.where(company_id: params[:company_id] )
      @company = Company.find( params[:company_id])
      sticker_filename = "VesselStickers_#{@company.code}_#{Date.today.strftime("%Y%m%d")}.pdf"
    elsif params[:vessel_id]
      @vessels = Vessel.where(id: params[:vessel_id] )
      sticker_filename = "VesselStickers_#{@vessels.first.ap2hi_ref}_#{Date.today.strftime("%Y%m%d")}.pdf"
    else
      @vessels = Vessel.all
      sticker_filename = "VesselStickers_#{Date.today.strftime("%Y%m%d")}.pdf"
    end
    flash[:success] = "A PDF contaning these stickers is being generated. An email will be sent to #{current_admin.email} when it's ready."
    PdfGeneratedJob.perform_later(current_admin.id, sticker_filename, @vessels.pluck(:id) )
    redirect_to :back
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
      :formatted_sipi_expiry,
      :return_to, 
      :material_type, 
      :machine_type, 
      :capacity, 
      :vms, 
      :tracker, 
      :port
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

