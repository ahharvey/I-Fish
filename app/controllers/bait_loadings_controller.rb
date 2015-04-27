class BaitLoadingsController < ApplicationController
  load_and_authorize_resource

  before_action :set_bait_loading, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    if params[:vessel_id]
      @bait_loadings = BaitLoading.where(vessel_id: params[:vessel_id])
      @vessel = Vessel.find(params[:vessel_id]) if params[:vessel_id]
    elsif params[:company_id]
      @vessels = Vessel.where(company_id: params[:company_id] )
      @company = Company.find(params[:company_id])
      @bait_loadings = BaitLoading.where(vessel_id: @vessels.pluck(:id) )
    end
    @vessels = Vessel.default unless params[:company_id]

    respond_with(@bait_loadings )
  end

  def show
    respond_with(@bait_loading)
  end

  def new
    @bait_loading = BaitLoading.new( vessel_id: params[:vessel_id])
    @vessel = Vessel.find( params[:vessel_id] ) if params[:vessel_id]
    @vessels = Vessel.where(company_id: params[:company_id] ) if params[:company_id]
    @vessels = Vessel.default unless params[:company_id]
    respond_with(@bait_loading)
  end

  def edit
    @vessels = Vessel.where(company_id: params[:company_id] ) if params[:company_id]
    @vessels = Vessel.default unless params[:company_id]
  end

  def create
    @bait_loading = BaitLoading.new(bait_loading_params)
    @bait_loading.save
    respond_with @bait_loading, location: -> { after_save_path_for(@bait_loading) }
  end

  def update
    @bait_loading.update(bait_loading_params)
    respond_with @bait_loading, location: -> { after_save_path_for(@bait_loading) }
  end

  def destroy
    @bait_loading.destroy
    respond_with(@bait_loading)
  end

  private
  
  def set_bait_loading
    @bait_loading = BaitLoading.find(params[:id])
  end

  def bait_loading_params
    params.require(:bait_loading).permit(
      :vessel,
      :formatted_date,
      :fish,
      :quantity,
      :price,
      :location,
      :method,

      )
  end

  def after_save_path_for(resource)
    bait_loading_path(resource)
  end

end

