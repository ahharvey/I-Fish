class BaitLoadingsController < ApplicationController

  # load_and_authorize_resource :vessel
  # load_and_authorize_resource :bait_loading, through: :vessel
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
    initialize_form 
    respond_with(@bait_loading)
  end

  def edit
    @vessels = Vessel.where(company_id: params[:company_id] ) if params[:company_id]
    @vessels = Vessel.default unless params[:company_id]
  end

  def create
    @bait_loading = BaitLoading.new(bait_loading_params)
    if @bait_loading.save
    else
      initialize_form 
      Rails.logger.info @bait_loading.errors.to_yaml
    end
    respond_with @bait_loading, location: -> { after_save_path_for(@bait_loading) }
  end

  def update
    initialize_form unless @bait_loading.update(bait_loading_params)
    respond_with @bait_loading, location: -> { after_save_path_for(@bait_loading) }
  end

  def destroy
    @bait_loading.destroy
    respond_with(@bait_loading)
  end

  def approve
    @bait_loading = BaitLoading.find( params[:id] )
    @bait_loading.approved!
    if @bait_loading.approved?
      track_activity @bait_loading
      @bait_loading.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("approved")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @bait_loading )
  end

  def reject
    @bait_loading = BaitLoading.find( params[:id] )
    @bait_loading.rejected!
    if @bait_loading.rejected?
      track_activity @bait_loading
      @bait_loading.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("Rejected")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @bait_loading )
  end

  def pend
    @bait_loading = BaitLoading.find( params[:id] )
    @bait_loading.pending!
    if @bait_loading.pending?
      track_activity @bait_loading
      @bait_loading.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("Pending")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @bait_loading )
  end

  private
  
  def set_bait_loading
    @bait_loading = BaitLoading.find(params[:id])
  end

  def initialize_form
    @vessel = Vessel.find( params[:vessel_id] ) if params[:vessel_id]
    @company = Company.find( params[:company_id] ) if params[:company_id]  
    
    if @vessel
      @vessels = Vessel.default
      @bait_fishes = @vessel.bait_fishes 
    elsif @company
      @vessels = Vessel.where(company_id: params[:company_id] )
      @bait_fishes = @company.bait_fishes 
    else
      @vessels = Vessel.default
      @bait_fishes = Fish.default
    end
  end

  def bait_loading_params
    params.require(:bait_loading).permit(
      :vessel_id,
      :formatted_date,
      :fish_id,
      :bait_id,
      :secondary_bait_id,
      :quantity,
      :price,
      :location,
      :method_type,

      )
  end

  def after_save_path_for(resource)
    bait_loading_path(resource)
  end

  def refresh_supervisor_controls( bait_loading )
    respond_to do |format|
      format.html { redirect_to bait_loading  }
      format.js {
        @bait_loading = bait_loading 
        render :refresh_supervisor_controls
      }
    end
  end

  def review_success_msg( state )
    "Bait loading successfully reviewed: #{state.upcase}"
  end

  def review_error_msg
    "We encountered an error reviewing this bait loading. Please try again."
  end

end

