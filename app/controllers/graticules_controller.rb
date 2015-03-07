class GraticulesController < ApplicationController
  load_and_authorize_resource

  before_action :set_graticule, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @graticules = Graticule.all
    respond_with(@graticules)
  end

  def show
    respond_with(@graticule)
  end

  def new
    @graticule = Graticule.new
    respond_with(@graticule)
  end

  def edit
  end

  def create
    @graticule = Graticule.new(graticule_params)
    @graticule.save
    respond_with @graticule, location: -> { after_save_path_for(@graticule) }
  end

  def update
    @graticule.update(graticule_params)
    respond_with @graticule, location: -> { after_save_path_for(@graticule) }
  end

  def destroy
    @graticule.destroy
    respond_with(@graticule)
  end

  private
  
  def set_graticule
    @graticule = Graticule.find(params[:id])
  end

  def graticule_params
    params.require(:graticule).permit(
      :code
      )
  end

  def after_save_path_for(resource)
    graticule_path(resource)
  end

end

