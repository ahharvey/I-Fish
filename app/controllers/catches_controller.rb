class CatchesController < ApplicationController
  load_and_authorize_resource

  before_action :set_fish, only: [:show, :edit, :update, :destroy]
  before_filter :load_fish, only: [:new, :edit]

  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @catches = Catch.includes(:fish).all
    respond_with(@catches)
  end

  def show
    respond_with(@catch)
  end

  def new
    @catch = Catch.new
    respond_with(@catch)
  end

  def edit
  end

  def create
    @catch = Catch.new(catch_params)
    @catch.save
    respond_with @catch, location: -> { after_save_path_for(@catch) }
  end

  def update
    @catch.update(catch_params)
    respond_with @catch, location: -> { after_save_path_for(@catch) }
  end

  def destroy
    @catch.destroy
    respond_with(@catch)
  end

  private
  
  def set_catch
    @catch = Catch.find(params[:id])
  end

  def load_fish
    @fish = Fish.all
  end

  def catch_params
    params.require(:catch).permit(
      :fish_id, 
      :length, 
      :weight, 
      :landing_id, 
      :sfactor, 
      :row, 
      :measurement
      )
  end

  def after_save_path_for(resource)
    catch_path(resource)
  end

end

