class WppsController < ApplicationController

  load_and_authorize_resource

  before_action :set_wpp, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @wpps = Wpp.default

    respond_with(@wpps)
  end

  def show
    respond_with(@wpps)
  end

  def new
    @wpp = Wpp.new
    respond_with(@wpp)
  end

  def edit
  end

  def create
    @wpp = Wpp.new(wpp_params)
    @wpp.save
    respond_with @wpp, location: -> { after_save_path_for(@wpp) }
  end

  def update
    @wpp.update(wpp_params)
    respond_with @wpp, location: -> { after_save_path_for(@wpp) }
  end

  def destroy
    @wpp.destroy
    respond_with(@wpp)
  end

  private

  def set_wpp
    @wpp = Wpp.find(params[:id])
  end

  def wpp_params
    params.require(:wpp).permit(
      :name
      )
  end

  def after_save_path_for(resource)
    wpp_path(resource)
  end

end
