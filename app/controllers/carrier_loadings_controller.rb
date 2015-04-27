class CarrierLoadingsController < ApplicationController
  load_and_authorize_resource

  before_action :set_carrier_loading, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    if params[:vessel_id]
      @carrier_loadings = CarrierLoading.where(vessel_id: params[:vessel_id])
      @vessel = Vessel.find(params[:vessel_id])
    elsif params[:company_id]
      @company = Company.find(params[:company_id])
      @vessels = Vessel.where(company_id: params[:company_id] )
      
      @carrier_loadings = CarrierLoading.where(vessel_id: @vessels.pluck(:id) )
    end
    @vessels = Vessel.default unless params[:company_id]

    respond_with(@carrier_loadings)
  end

  def show
    respond_with(@carrier_loading)
  end

  def new
    @carrier_loading = CarrierLoading.new
    @vessel = Vessel.find( params[:vessel_id] ) if params[:vessel_id]
    @vessels = Vessel.where(company_id: params[:company_id] ) if params[:company_id]
    @vessels = Vessel.default unless params[:company_id]
    respond_with(@carrier_loading)
  end

  def edit

    @vessels = Vessel.where(company_id: params[:company_id] ) if params[:company_id]
    @vessels = Vessel.default unless params[:company_id]
  end

  def create
    @carrier_loading = CarrierLoading.new(vessel_params)
    track_activity @carrier_loading if @carrier_loading.save
    respond_with @carrier_loading, location: -> { after_save_path_for(@carrier_loading) }
  end

  def update
    track_activity @carrier_loading if @carrier_loading.update(vessel_params)
    respond_with @carrier_loading, location: -> { after_save_path_for(@carrier_loading) }
  end

  def destroy
    track_activity @carrier_loading if @carrier_loading.destroy
    respond_with(@carrier_loading)
  end

  private
  
  def set_vessel
    @carrier_loading = CarrierLoading.find(params[:id])
  end

  def vessel_params
    params.require(:carrier_loading).permit(
      
      :date,
      :vessel,
      :fish, 
      :location,
      :size,
      :grade,
      :quantity
      )
  end


  def after_save_path_for(resource)
    carrier_loading_path(resource)
  end

end

