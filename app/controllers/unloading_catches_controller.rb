
class UnloadingCatchesController < ApplicationController
  load_and_authorize_resource

  before_action :set_unloading_catch, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

#  def index
#    @unloading_catches = UnloadingCatch.all
#    respond_with(@unloading_catches)
#  end#

#  def show
#    respond_with(@unloaunloading_catch)
#  end#

#  def new
#    @unloading_catch = Unloading.new
#    respond_with(@unloading_catch)
#  end#

#  def edit
#  end

  def create
    @unloading_catch = UnloadingCatch.new(unloading_catch_params)
    respond_to do |format|
      if @unloading_catch.save
        format.html { redirect_to @unloading_catch.unloading, notice: t('.notice') }
        format.json { render :show, status: :created, location: @unloading_catch }
      else
        format.html { render 'unloadings/show' }
        format.json { render json: @unloading_catch.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @unloading_catch.update(unloading_catch_params)
        format.html { redirect_to @unloading_catch.unloading, notice: t('.notice') }
        format.json { respond_with_bip(@unloading_catch) }
      else
        format.html { render 'unloadings/show' }
        format.json { respond_with_bip(@unloading_catch) }
      end
    end
  end

  def destroy
    @unloading_catch.destroy
    respond_to do |format|
      format.html { redirect_to unloading_path(@unloading_catch.unloading), notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private

  def set_unloading_catch
    @unloading_catch = UnloadingCatch.find(params[:id])
  end

  def unloading_catch_params
    params.require(:unloading_catch).permit(
      :fish_id,
      :quantity,
      :unloading_id
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
