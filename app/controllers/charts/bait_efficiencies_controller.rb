class Charts::BaitEfficienciesController < ApplicationController
  authorize_resource class: Charts::BaitEfficienciesController
  def index
    if params[:period] == 'current'
      catches = fetch_parent.unloading_catches.current.group_by_month_of_year('unloadings.time_in', format: '%b').sum(:quantity)
      baits   = fetch_parent.bait_loadings.current.group_by_month_of_year(:date, format: '%b').sum(:quantity)
    else
      catches = fetch_parent.unloading_catches.group_by_month_of_year('unloadings.time_in', format: '%b').sum(:quantity)
      baits   = fetch_parent.bait_loadings.group_by_month_of_year(:date, format: '%b').sum(:quantity)
    end

    @data = Hash.new
    catches.each do |k,v|

      adj = 0                     if       v == 0
      adj = (100 * baits[k].to_f)/ v.to_f  unless   v == 0

      @data[k] = adj
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
