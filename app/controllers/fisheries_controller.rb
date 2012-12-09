class FisheriesController < InheritedResources::Base
  load_and_authorize_resource

  def show
  	respond_to do |format|
  	  @fishery = Fishery.find(params[:id])
      # surveys = @user.surveys.order("date_published")
      format.html { render }

  	  format.json do
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
	        surveys = @fishery.surveys.select{ |s| s.date_published.year == y && s.date_published.month == m}.each do |s|
	          landings.concat(s.landings)
	        end
	        x = landings.map{ |l| l.weight / ((l.time_in.to_time - l.time_out.to_time) / 1.hour)}.inject(0, :+)
	        month_counts.push x
	      end
	    end
  	  	render json: {:col_headers => col_headers, :month_counts => month_counts }
  	  end
  	end
  end
end
