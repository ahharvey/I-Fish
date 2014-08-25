class FisheriesController < InheritedResources::Base
  load_and_authorize_resource
  skip_before_filter :authenticate!
  
  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def show
    #@chart = @fishery.surveys.group("DATE_TRUNC('month', survey.date_published)").order("DATE_TRUNC('month', survey.date_published)").average('landings.cpue_kg')
    #@chart = Hash[@chart.map { |k, v| [Time.parse(k).utc.to_i*1000, v.to_f.round(0)] }].to_a
    respond_to do |format|
      @date_from = (DateTime.now - 1.years).strftime("%d/%m/%Y")
      @date_to = DateTime.now.strftime("%d/%m/%Y")
      @fishery = Fishery.find(params[:id])

      format.html { render }
      format.xml { render :xml=>@fishery.to_xml(include: { :surveys => {include: { :landings => { include: :catches }}}} ) }
      format.json do
        graph_catch_per_effort() if params[:method] == "catch_per_effort"
        graph_length_frequency() if params[:method] == "length_frequency"
        graph_values() if params[:method] == "value"
        graph_catch_composition() if params[:method] == "catch_composition"
        graph_fishing_activity() if params[:method] == "activity"
        render :json=>@fishery.to_json(include: { :surveys => {include: { :landings => { include: :catches }}}} ) unless params.has_key?(:method)
        
      end
      format.xls
    end
  end

  protected

  def graph_catch_per_effort
    @fishery = Fishery.find(params[:id])
    col_headers = []
    month_counts = []
    from = DateTime.parse(params[:date_from])
    to = DateTime.parse(params[:date_to])
    (from.year..to.year).each do |y|
      start_month = (from.year == y) ? from.month : 1
      end_month = (to.year == y) ? to.month : 12

      (start_month..end_month).each do |m|
        col_headers.push "#{Date::MONTHNAMES[m].slice(0,3)} #{y.to_s.slice(2,2)}"
        surveys_from = Date.new(y,m,15).beginning_of_month
        surveys_to = Date.new(y,m,15).end_of_month
        landings = Landing.joins(:survey).where('surveys.date_published >= ? AND surveys.date_published <= ? AND surveys.fishery_id = ?', surveys_from, surveys_to, @fishery.id) 

        res = []
        ls=landings.where('landings.time_out != landings.time_in')
        ls.each do |l| 
          if l.weight.zero? && l.quantity.zero?
            cpue = 0.to_i 
          elsif !l.weight.zero?
            cpue = l.weight / ((l.time_in.to_time - l.time_out.to_time) / 1.hour)
            cpue = cpue / 1000
          elsif !l.quantity.zero?
            cpue = (l.quantity*350) / ((l.time_in.to_time - l.time_out.to_time) / 1.hour)
            cpue = cpue / 1000
          end
          res.push cpue
        end
        res = res.inject(0, :+)
        res = res / landings.count if landings.count > 0
        month_counts.push res
      end
    end
    render json: {:col_headers => col_headers, :month_counts => month_counts }
  end

  def graph_fishing_activity
    @fishery = Fishery.find(params[:id])
    col_headers = []
    month_counts = []
    from = DateTime.parse(params[:date_from])
    to = DateTime.parse(params[:date_to])
    logged_days = LoggedDay.joins(:logbook).where('logbooks.fishery_id = ? AND logbooks.date >= ? AND logbooks.date <= ?', @fishery.id, from, to )
    active_days = logged_days.where(:end_time > :start_time)
    active_counts = active_days.group("DATE_TRUNC('day', start_time)").order("DATE_TRUNC('day', start_time)").count
    logged_counts = logged_days.group("DATE_TRUNC('day', start_time)").order("DATE_TRUNC('day', start_time)").count
    active_counts.each do |ac|
      key = ac[0]
      value = ac[1]
      logged_counts[key] = value.to_f / logged_counts[key]
    end
    logged_counts = Hash[ logged_counts.map { |k, v| [Time.parse(k.to_s).utc.to_i*1000, v*100] }].to_a
    render json: logged_counts
  end

  def graph_catch_composition
    @fishery = Fishery.find(params[:id])
    from = DateTime.parse(params[:date_from])
    to = DateTime.parse(params[:date_to])
    catches = Catch.
        joins(:survey, :fishery).
        where("fisheries.id = ? AND surveys.date_published >= ? AND surveys.date_published <= ?", @fishery.id, from, to)
    counts = catches.group('catches.fish_id').count
    formatted = Hash[counts.map { |k, v| [k==0 ? "Unidentified" : Fish.find(k).scientific_name, v] }]
    render json: formatted.to_a
  end

  def graph_length_frequency
    catches = []
    fishery = Fishery.find(params[:id])
    species = Fish.find(params[:species])
    from = DateTime.parse(params[:date_from])
    to = DateTime.parse(params[:date_to])
    catches = Catch.
      joins(:landing, :survey, :fishery).
      where('fisheries.id = ? AND catches.fish_id = ? AND surveys.date_published >= ? AND surveys.date_published <= ?', fishery.id, species, from, to)
    step = 5
    catches = catches.sort_by &:length
    lengths = catches.map{ |c| c.length - (c.length % step) }.uniq
    length_counts = lengths.map{ |l| catches.select{ |c| c.length - (c.length % step) == l }.count}

    render json: {:col_headers => lengths, :length_counts => length_counts }
  end

  def graph_values
    @fishery = Fishery.find(params[:id])
    col_headers = []
    month_counts = []
    from = DateTime.parse(params[:date_from])
    to = DateTime.parse(params[:date_to])
    (from.year..to.year).each do |y|
      start_month = (from.year == y) ? from.month : 1
      end_month = (to.year == y) ? to.month : 12

      (start_month..end_month).each do |m|
        col_headers.push "#{Date::MONTHNAMES[m].slice(0,3)} #{y.to_s.slice(2,2)}"
        surveys_from = Date.new(y,m,15).beginning_of_month
        surveys_to = Date.new(y,m,15).end_of_month
        landings = Landing.joins(:survey).where('surveys.date_published >= ? AND surveys.date_published <= ? AND surveys.fishery_id = ?', surveys_from, surveys_to, @fishery.id) 
        res = []
        ls=landings.where('landings.time_out != landings.time_in')
        ls.each do |l| 
          if l.value.zero?
            value = 0.to_i 
          else 
            value = l.value/ ((l.time_in.to_time - l.time_out.to_time) / 1.hour)
          end
          res.push value
        end
        res = res.inject(0, :+)
        res = res / landings.count if landings.count > 0
        month_counts.push res
      end
    end
    render json: {:col_headers => col_headers, :month_counts => month_counts }
  end
end
