class ProtocolsController < ApplicationController
  load_and_authorize_resource

  before_action :set_protocol, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @protocols = Protocol.all
    respond_with(@protocols)
  end

  def show
    respond_with(@protocol)
  end

  def new
    @protocol = Protocol.new
    respond_with(@protocol)
  end

  def edit
  end

  def create
    @protocol = Protocol.new(protocol_params)
    @protocol.save
    respond_with @protocol, location: -> { after_save_path_for(@protocol) }
  end

  def update
    @protocol.update(protocol_params)
    respond_with @protocol, location: -> { after_save_path_for(@protocol) }
  end

  def destroy
    @protocol.destroy
    respond_with(@protocol)
  end

  private
  
  def set_protocol
    @protocol = Protocol.find(params[:id])
  end

  def protocol_params
    params.require(:protocol).permit( :title, :description )
  end

  def after_save_path_for(resource)
    protocol_path(resource)
  end

end


