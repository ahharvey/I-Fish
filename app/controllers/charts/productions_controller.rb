class Charts::ProductionsController < ApplicationController
  authorize_resource class: Charts::ProductionsController
  def index
    if params[:period] == 'current'
      @data = fetch_parent.unloading_catches.current.to_monthly_production_chart
    else
      @data = fetch_parent.unloading_catches.to_monthly_production_chart
    end


    render json: @data.chart_json
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
