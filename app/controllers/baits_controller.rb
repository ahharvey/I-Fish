class BaitsController < ApplicationController
  load_and_authorize_resource

  before_action :set_bait, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @baits = Bait.all
    respond_with(@baits)
  end

  def show
    respond_with(@bait)
  end

  def new
    @bait = Bait.new
    respond_with(@bait)
  end

  def edit
  end

  def create
    @bait = Bait.new(bait_params)
    @bait.save
    respond_with @bait, location: -> { after_save_path_for(@bait) }
  end

  def update
    @bait.update(bait_params)
    respond_with @bait, location: -> { after_save_path_for(@bait) }
  end

  def destroy
    @bait.destroy
    respond_with(@bait)
  end

  private
  
  def set_bait
    @bait = Bait.find(params[:id])
  end

  def bait_params
    params.require(:bait).permit(
      :name,
      :code
      )
  end

  def after_save_path_for(resource)
    bait_path(resource)
  end

end

