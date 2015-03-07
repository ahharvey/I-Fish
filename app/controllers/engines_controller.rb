class EnginesController < ApplicationController
  load_and_authorize_resource

  before_action :set_engine, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @engines = Engine.all
    respond_with(@engines)
  end

  def show
    respond_with(@engine)
  end

  def new
    @engine = Engine.new
    respond_with(@engine)
  end

  def edit
  end

  def create
    @engine = Engine.new(engine_params)
    @engine.save
    respond_with @engine, location: -> { after_save_path_for(@engine) }
  end

  def update
    @engine.update(engine_params)
    respond_with @engine, location: -> { after_save_path_for(@engine) }
  end

  def destroy
    @engine.destroy
    respond_with(@engine)
  end

  private
  
  def set_engine
    @engine = Engine.find(params[:id])
  end

  def engine_params
    params.require(:engine).permit(
      :name, 
      :code
      )
  end

  def after_save_path_for(resource)
    engine_path(resource)
  end

end

