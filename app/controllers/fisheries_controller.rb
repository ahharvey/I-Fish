class FisheriesController < InheritedResources::Base
  load_and_authorize_resource

  def show
  	respond_to do |format|
  	  @fishery = Fishery.find(params[:id])

      format.html { render }

      format.json do
  	  	graph_catch_per_effort() if params[:method] == "catch_per_effort"
  	  	graph_length_frequency() if params[:method] == "length_frequency"
  	  end
  	end
  end

  protected

  def graph_catch_per_effort
  	@fisheries = Fishery.find(params[:id])
  	col_headers = []
	month_counts = []
	from = DateTime.new(Integer(params[:year_from]), Integer(params[:month_from]), 1)
  to = DateTime.new(Integer(params[:year_to]), Integer(params[:month_to]), 1)
  (from.year..to.year).each do |y|
    start_month = (from.year == y) ? from.month : 1
    end_month = (to.year == y) ? to.month : 12

    (start_month..end_month).each do |m|
      col_headers.push "#{Date::MONTHNAMES[m].slice(0,3)} #{y.to_s.slice(2,2)}"
      landings = []
      surveys = @fisheries.surveys.select{ |s| s.date_published.year == y && s.date_published.month == m}.each do |s|
        landings.concat(s.landings)
      end
      month_counts.push landings.map{ |l| l.weight / ((l.time_in.to_time - l.time_out.to_time) / 1.hour)}.inject(0, :+)
    end
  end
		render json: {:col_headers => col_headers, :month_counts => month_counts }
  end

  def graph_length_frequency
  	catches = []
    from = DateTime.new(Integer(params[:year_from]), Integer(params[:month_from]), 1)
    to = DateTime.new(Integer(params[:year_to]), Integer(params[:month_to]), 1)
  	@fisheries = Fishery.find(params[:id]).surveys.where(:date_published => from..to ).each do |s|
      s.landings.each do |l|
        catches.concat l.catches
      end
    end
    step = 5
    lengths = catches.map{ |c| c.length - (c.length % step) }.uniq
    length_counts = lengths.map{ |l| catches.select{ |c| c.length - (c.length % step) == l }.count}

    render json: {:col_headers => lengths, :length_counts => length_counts }
  end
end
