class UsersController < InheritedResources::Base
  load_and_authorize_resource

  def show
  	respond_to do |format|
  	  @user = User.find(params[:id])
      surveys = @user.surveys.order("date_published")

      # binding.pry

  	  format.html do
  	  	1.upto(12) { |i| instance_variable_set("@month_#{i}", 0) }
          surveys.each do |survey|
          instance_variable_set("@month_#{survey.date_published.month}", instance_variable_get("@month_#{survey.date_published.month}")+1) rescue nil
        end
  	  	render
  	  end

  	  format.json do
  	  	col_headers = []
  	  	month_counts = []
  	  	from = DateTime.new(Integer(params[:year_from]), Integer(params[:month_from]), 1)
	    to = DateTime.new(Integer(params[:year_to]), Integer(params[:month_to]), 1)
	    (from.year..to.year).each do |y|
	      # binding.pry
	      start_month = (from.year == y) ? from.month : 1
	      end_month = (to.year == y) ? to.month : 12

	      (start_month..end_month).each do |m|
	        col_headers.push "#{Date::MONTHNAMES[m].slice(0,3)} #{y.to_s.slice(2,2)}"
	        month_counts.push surveys.select{ |s| s.date_published.year == y && s.date_published.month == m}.count
	      end
	    end
	    # surveys.map{ |s| {:month => s.date_published.strftime("%m"), :year => s.date_published.strftime("%Y")} }
  	  	render json: {:col_headers => col_headers, :month_counts => month_counts }
  	  end
  	end
  end
end