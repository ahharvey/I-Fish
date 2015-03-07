class FishesController < ApplicationController
  load_and_authorize_resource

  before_action :set_fish, only: [:show, :edit, :update, :destroy]
  
  respond_to :html, :xml, :json

  def index
    @fishes = Fish.all
    respond_with(@fishes)
  end

  def show
    respond_with(@fish)
  end

  def new
    @fish = Fish.new( code: params[:code], fishery_id: params[:fishery_id] )
    respond_with(@fish)
  end

  def edit
  end

  def create
    @fish = Fish.new(fish_params)
    @fish.save
    respond_with @fish, location: -> { after_save_path_for(@fish) }
  end

  def update
    @fish.update(fish_params)
    respond_with @fish, location: -> { after_save_path_for(@fish) }
  end

  def destroy
    @fish.destroy
    respond_with(@fish)
  end

  def import
    Fish.import(params[:file])
    redirect_to fishes_url, notice: "New species imported."
  end

  def autocomplete
    @fishes = Fish.order(:scientific_name).where("scientific_name ilike ?", "#{params[:term]}")
    render json: @fishes.map(&:scientific_name)
  end

  private
  
  def set_fish
    @fish = Fish.find(params[:id])
  end

  def fish_params
    params.require(:fish).permit(
      :code, 
      :english_name, 
      :family, 
      :fishbase_name, 
      :indonesia_name, 
      :order, 
      :scientific_name, 
      :a, 
      :b, 
      :max, 
      :mat, 
      :opt, 
      :threatened,
      :fishery_id
      )
  end

  def after_save_path_for(resource)
    if params[:fish][:fishery_id].present?
      fishery = Fishery.find( params[:fish][:fishery_id] )
      fishery.target_fishes.push resource
      fishery_path(params[:fish][:fishery_id])
    else
      fish_path(resource)
    end
  end

end


