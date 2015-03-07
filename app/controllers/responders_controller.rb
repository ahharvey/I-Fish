class RespondersController < ApplicationController
  before_action :set_responder, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @responders = Responder.all
    respond_with(@responders)
  end

  def show
    respond_with(@responder)
  end

  def new
    @responder = Responder.new
    respond_with(@responder)
  end

  def edit
  end

  def create
    @responder = Responder.new(responder_params)
    @responder.save
    respond_with @responder, location: -> { thing_path(@thing) }
  end

  def update
    @responder.update(responder_params)
    respond_with @responder, location: -> { thing_path(@thing) }
  end

  def destroy
    @responder.destroy
    respond_with(@responder)
  end

  private
    def set_responder
      @responder = Responder.find(params[:id])
    end

    def responder_params
      params.require(:responder).permit(:name, :length)
    end
end
