class Charts::FuelUtilizationsController < ApplicationController
  authorize_resource class: Charts::FuelUtilizationsController
  def index
    if params[:period] == 'current'
      @data = fetch_parent.unloadings.current.to_monthly_fuel_utilization
    else
      @data = fetch_parent.unloadings.to_monthly_fuel_utilization
    end

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
