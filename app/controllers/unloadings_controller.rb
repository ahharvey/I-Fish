
class UnloadingsController < ApplicationController
  load_and_authorize_resource

  before_action :set_unloading, only: [:show, :edit, :update, :destroy]

  respond_to :html, :xml, :json, :csv, :xls, :js

  def index
    if params[:vessel_id]
      @unloadings = Vessel.find( params[:vessel_id] ).unloadings
      @unloading = Unloading.new( vessel_id: params[:vessel_id])
      @vessel = Vessel.find(params[:vessel_id])
      
    else
      @unloadings = Unloading.all
    end
    respond_with(@unloadings)
  end

  def show
    respond_with(@unloading)
  end

  def new
    @unloading = Unloading.new( vessel_id: params[:vessel_id])
    @vessel = Vessel.find( params[:vessel_id] ) if params[:vessel_id]
    build_nested_forms( @unloading, @vessel ) if params[:vessel_id]
    respond_with(@unloading)
  end

  def edit
    @vessel = Vessel.find( params[:vessel_id] ) if params[:vessel_id]
  end

  def create
    #temp_params = unloading_params
    #temp_params[:time_out] = Date.strptime(temp_params[:time_out], '%m/%d/%Y %I:%M %p') rescue ''
    #temp_params[:time_in] = Date.strptime(temp_params[:time_in], '%m/%d/%Y %I:%M %p') rescue ''
    @unloading = Unloading.new(unloading_params)
    track_activity @unloading if @unloading.save
    respond_with @unloading, location: -> { after_save_path_for(@unloading) }
#    respond_to do |format|
#      if @unloading.save
#        format.html { redirect_to after_save_path_for(@unloading), notice: 'Person was successfully created.' }
#        format.json { render action: 'index', status: :created, location: @unloading }
#        # added:
#        format.js   { render action: 'index', status: :created, location: @unloading }
#      else
#        flash[:error] = @unloading.errors.full_messages.join(", ")
#        format.html { render action: 'new' }
#        format.json { render json: @unloading.errors, status: :unprocessable_entity }
#        # added:
#        format.js   { render json: @unloading.errors, status: :unprocessable_entity }
#      end
#    end
  end

  def update
    @vessel = Vessel.find(params[:vessel_id]) if params[:vessel_id]
    if @unloading.update(unloading_params)
      track_activity @unloading
      if params[:unloading][:bait_loading_attributes].present?
        flash[:success] = "Bait Loading updated successfully!"
      else 
        flash[:success] = "Unloading Record updated successfully!"
      end
    else
      flash[:error] = @unloading.errors.full_messages.join(", ")
    end

    respond_with @unloading, location: -> { after_save_path_for(@unloading) } do |format|
      format.json { respond_with_bip @unloading } 
    end

  end

  def destroy
    track_activity @unloading if @unloading.destroy
    respond_with(@unloading)
  end

  private
  
  def set_unloading
    @unloading = Unloading.find(params[:id])
  end

  def unloading_params
    params.require(:unloading).permit(
      :vessel_id,
      :port, 
      :time_out,
      :time_in,
      :formatted_time_out,
      :formatted_time_in,
      :yft,
      :bet,
      :skj,
      :kaw,
      :byproduct,
      :discard,
      :etp,
      :location,
      :fuel,
      :ice,
      unloading_catches_attributes: [
        :id,
        :fish_id,
        :cut_type,
        :quantity,
        :_destroy
        ],
      bait_loadings_attributes: [
        :id, 
        :date,
        :quantity, 
        :location,
        :fish_id,
        :vessel_id,
        :formatted_date,
        :_destroy
        ]
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

