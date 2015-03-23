
class UnloadingCatchesController < ApplicationController
  load_and_authorize_resource

  before_action :set_unloading_catch, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @unloading_catches = UnloadingCatch.all
    respond_with(@unloading_catches)
  end

  def show
    respond_with(@unloaunloading_catch)
  end

  def new
    @unloading_catch = Unloading.new
    respond_with(@unloading_catch)
  end

  def edit
  end

  def create
    @unloading_catch = UnloadingCatch.new(unloading_catch_params)
    @unloading_catch.save
    respond_with @unloading_catch, location: -> { after_save_path_for(@unloading_catch) }
  end

  def update
    @unloaunloading_catch.update(unloading_catch_params)
    respond_with @unloading_catch, location: -> { after_save_path_for(@unloading_catch) }
  end

  def destroy
    @unloading_catch.destroy
    respond_with(@unloading_catch)
  end

  private
  
  def set_unloading_catch
    @unloading_catch = UnloadingCatch.find(params[:id])
  end

  def unloading_catch_params
    params.require(:unloading_catch).permit(
      :fish_id,
      :quantity
      )
  end

  def after_save_path_for(resource)
    if params[:unloading][:vessel_id].present?
      vessel_path( params[:unloading][:vessel_id] )
    else
      unloading_path(resource)
    end
  end

end

