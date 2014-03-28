class FishesController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json

  def import
    Fish.import(params[:file])
    redirect_to fishes_url, notice: "New species imported."
  end
end
