class PortsController < ApplicationController

  load_and_authorize_resource

  before_action :set_port, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ports = Port.default

    respond_with(@ports)
  end

  def show
    respond_with(@ports)
  end

  def new
    @port = Port.new
    respond_with(@port)
  end

  def edit
  end

  def create
    @port = Port.new(port_params)
    @port.save
    respond_with @port, location: -> { after_save_path_for(@port) }
  end

  def update
    @port.update(port_params)
    respond_with @port, location: -> { after_save_path_for(@port) }
  end

  def destroy
    @port.destroy
    respond_with(@port)
  end

  private

  def set_port
    @port = Port.find(params[:id])
  end

  def port_params
    params.require(:port).permit(
      :name
      )
  end

  def after_save_path_for(resource)
    port_path(resource)
  end

end
