
class UnloadingsController < ApplicationController
  load_and_authorize_resource

  before_action :set_unloading, only: [:show, :edit, :update, :destroy]

  respond_to :html, :xml, :json, :csv, :xls, :js

  def index
    fetch_index_records
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"unloadings-#{Date.current}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show
  end

  def new
    @unloading = Unloading.new( vessel_id: params[:vessel_id])
    @vessel = Vessel.find( params[:vessel_id] ) if params[:vessel_id]
    build_nested_forms( @unloading, @vessel ) if params[:vessel_id]
  end

  def edit
    @vessel = Vessel.find( params[:vessel_id] ) if params[:vessel_id]
  end

  def create
    #temp_params = unloading_params
    #temp_params[:time_out] = Date.strptime(temp_params[:time_out], '%m/%d/%Y %I:%M %p') rescue ''
    #temp_params[:time_in] = Date.strptime(temp_params[:time_in], '%m/%d/%Y %I:%M %p') rescue ''
    @unloading = Unloading.new(unloading_params.merge( user_id: current_user.try(:id), admin_id: current_admin.try(:id) ) )
    respond_to do |format|
      if @unloading.save
        track_activity @unloading
        format.html { redirect_to @unloading, notice: t('.notice') }
        format.json { render :show, status: :created, location: @unloading }
      else
        format.html { render :new }
        format.json { render json: @unloading.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @vessel = Vessel.find(params[:vessel_id]) if params[:vessel_id]
    respond_to do |format|
      if @unloading.update(unloading_params)
        track_activity @unloading
        if params[:unloading][:bait_loading_attributes].present?
          msg = "Bait Loading updated successfully!"
        else
          msg = "Unloading Record updated successfully!"
        end
        format.html { redirect_to @unloading, notice: msg }
        format.json { respond_with_bip(@unloading) }
      else
        #flash[:error] = @unloading.errors.full_messages.join(", ")
        format.html { render :edit }
        format.json { respond_with_bip(@unloading) }
      end
    end

#    respond_with @unloading, location: -> { after_save_path_for(@unloading) } do |format|
#      format.json { respond_with_bip @unloading }
#    end

  end

  def destroy
    track_activity @unloading if @unloading.destroy
    respond_to do |format|
      format.html { redirect_to unloadings_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  def approve
    @unloading = Unloading.find( params[:id] )
    @unloading.approved!
    if @unloading.approved?
      track_activity @unloading
      @unloading.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("approved")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @unloading )
  end

  def reject
    @unloading = Unloading.find( params[:id] )
    @unloading.rejected!
    if @unloading.rejected?
      track_activity @unloading
      @survey.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("Rejected")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @unloading )
  end

  def pend
    @unloading = Unloading.find( params[:id] )
    @unloading.pending!
    if @unloading.pending?
      track_activity @unloading
      @unloading.update_column :reviewer_id, current_admin.id
      flash[:success] = review_success_msg("Pending")
    else
      flash[:error] = review_error_msg
    end
    refresh_supervisor_controls( @unloading )
  end

  private

  def fetch_index_records
    if klass = [Vessel, Company].detect { |k| params["#{k.name.underscore}_id"]}
      @unloadings = klass.
        find( params["#{klass.name.underscore}_id"] ).
        unloadings.
        default.
        page(params[:page])
    else
      @unloadings = Unloading.
        default.
        page(params[:page])
    end
  end

  def set_unloading
    @unloading = Unloading.find(params[:id])
  end

  def unloading_params
    params.require(:unloading).permit(
      :port_id,
      :wpp_id,
      :vessel_id,
      :formatted_time_out,
      :formatted_time_in,
      :etp,
      :location,
      :fuel,
      :ice,
      :review_state,
      :byproduct,
      :discard,
      :yft,
      :bet,
      :skj,
      :kaw,
      :catch_certificate


#      :vessel_id,
#      :port_id,
#      :wpp_id,
#      :time_out,
#      :time_in,
#      :formatted_time_out,
#      :formatted_time_in,
#      :yft,
#      :bet,
#      :skj,
#      :kaw,
#      :byproduct,
#      :discard,
#      :etp,
#      :location,
#      :fuel,
#      :ice,
#      unloading_catches_attributes: [
#        :id,
#        :fish_id,
#        :cut_type,
#        :quantity,
#        :_destroy
#        ],
#      bait_loadings_attributes: [
#        :id,
#        :date,
#        :quantity,
#        :location,
#        :fish_id,
#        :vessel_id,
#        :formatted_date,
#        :_destroy
#        ]
      )
  end

  def after_save_path_for(resource)
    if params[:unloading][:vessel_id].present? #|| params[:unloading][:bait_loading_attributes].present?
      vessel_unloadings_path( params[:unloading][:vessel_id] )
    else
      unloading_path(resource)
    end
  end

  def build_nested_forms( unloading, vessel )
    if vessel.vessel_type.present?
      if vessel.vessel_type.code == 'pol'
        ['YFT','BET','SKJ','KAW'].each do |t|
          tuna = Fish.find_by(code: t)
          unloading.unloading_catches.build(fish_id: tuna.id)
        end
        3.times { unloading.bait_loadings.build }
      elsif vessel.vessel_type.code == 'hl'
        ['YFT'].each do |t|
          tuna = Fish.find_by(code: t)
          ['dirtyloin','cleanloin'].each do |c|
            unloading.unloading_catches.build(fish_id: tuna.id, cut_type: c)
          end
        end
        unloading.bait_loadings.build
      end
    end
  end

  def refresh_supervisor_controls( unloading )
    respond_to do |format|
      format.html { redirect_to unloading  }
      format.js {
        @unloading = unloading
        render :refresh_supervisor_controls
      }
    end
  end

  def review_success_msg( state )
    "Unloading successfully reviewed: #{state.upcase}"
  end

  def review_error_msg
    "We encountered an error reviewing this unloading. Please try again."
  end

end
