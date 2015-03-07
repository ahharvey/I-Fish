class DesasController < ApplicationController
  load_and_authorize_resource

  before_action :set_desa, only: [:show, :edit, :update, :destroy]

  respond_to :html, :xml, :json

  def index
    @desas = Desa.all
    @hash = Gmaps4rails.build_markers(@desas) do |desa, marker|
      marker.lat desa.lat
      marker.lng desa.lng
    end
    respond_with(@desas)
  end

  def show
    initialize_placemarks( @desa )
    respond_with(@desa)
  end

  def new
    @desa = Desa.new
    initialize_placemarks( @desa )
    respond_with(@desa)
  end

  def edit
    initialize_placemarks( @desa )
  end

  def create
    @desa = Desa.new(desa_params)
    @desa.save
    respond_with @desa, location: -> { after_save_path_for(@desa) }
  end

  def update
    @desa.update(desa_params)
    respond_with @desa, location: -> { after_save_path_for(@desa) }
  end

  def destroy
    @desa.destroy
    respond_with(@desa)
  end

  private
  
  def set_desa
    @desa = Desa.find(params[:id])
  end

  def desa_params
    params.require(:desa).permit(
      :name, 
      :kabupaten, 
      :code, 
      :lat, 
      :lng, 
      :district_id
      )
  end

  def after_save_path_for(resource)
    desa_path(resource)
  end

  def initialize_placemarks(resource)
    @placemarks = Gmaps4rails.build_markers(resource) do |desa, marker|
      marker.lat desa.lat
      marker.lng desa.lng
      marker.title   desa.name
      marker.json({ :id => desa.id })
    end
  end

  
end




