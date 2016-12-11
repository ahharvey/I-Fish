class Charts::BaitEfficienciesController < ApplicationController
  authorize_resource class: Charts::BaitEfficienciesController
  def index
    @data = fetch_parent.to_bait_ratio current: true if params[:period] == 'current'
    @data = fetch_parent.to_bait_ratio               unless params[:period] == 'current'

    render json: @data
  end
private
  def fetch_parent
    if klass = [Company, Vessel, Fishery, Port, Wpp].detect { |k| params["#{k.name.underscore}_id"]}
      @object = klass.find( params["#{klass.name.underscore}_id"] )
    else
      @object = nil
    end
  end
end
