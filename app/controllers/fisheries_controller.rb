class FisheriesController < ApplicationController
  load_and_authorize_resource
  #before_action :set_fishery, only: [:show, :edit, :update, :destroy]

  layout :select_layout

  #skip_before_filter :authenticate!

  #respond_to :html
  #respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  autocomplete :fish, :scientific_name

  def index
    @fisheries = @fisheries.default.page(params[:page])
    respond_to do |format|
      format.html
      format.js
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"fisheries-#{Date.current}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show
  end

  def new
    #@fishery = Fishery.new
  end

  def edit
  end

  def create
    @fishery = Fishery.new(fishery_params)
    respond_to do |format|
      if @fishery.save
        format.html { redirect_to @fishery, notice: t('.notice') }
        format.json { render :show, status: :created, location: @fishery }
      else
        format.html { render :new }
        format.json { render json: @fishery.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @fishery.attributes = fishery_params
    respond_to do |format|
      if @fishery.save_draft
        format.html { redirect_to @fishery, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @fishery }
      else
        format.html { render :edit }
        format.json { render json: @fishery.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fishery.destroy
    respond_to do |format|
      format.html { redirect_to fisheries_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  def get_fish
    fish.try(:scientific_name)
  end


  def add_target_fish
    fish = Fish.find_by_code params[:get_fish]
    if fish
      if @fishery.target_fishes.include?(fish)
        flash[:alert]= I18n.t("fisheries.target_fishes.exists")
      else
       @fishery.target_fishes.push fish
       flash[:success]= I18n.t("fisheries.target_fishes.created")
      end
      redisplay_target_fishes
    else
      render js: "window.location = #{new_fish_path(fishery_id: params[:id], code: params[:get_fish]).to_json}"
    end

  end

  def delete_target_fish
    @fishery.target_fishes.delete(Fish.find params[:target_fish])
    flash[:success]= I18n.t("fisheries.target_fishes.removed")
    redisplay_target_fishes
  end

  def add_bait_fish
    fish = Fish.find_by_code params[:get_bait]
    if fish
      if @fishery.bait_fishes.include?(fish)
        flash[:alert]= I18n.t("fisheries.bait_fishes.exists")
      else
       @fishery.bait_fishes.push fish
       flash[:success]= I18n.t("fisheries.bait_fishes.created")
      end
      redisplay_bait_fishes
    else
      render js: "window.location = #{new_fish_path(fishery_id: params[:id], code: params[:get_bait]).to_json}"
    end

  end

  def delete_bait_fish
    @fishery.bait_fishes.delete(Fish.find params[:target_fish])
    flash[:success]= I18n.t("fisheries.bait_fishes.removed")
    redisplay_bait_fishes
  end

  def add_used_gear
    gear = Gear.find_by_alpha_code params[:get_gear]
    if gear
      if @fishery.used_gears.include?(gear)
        flash[:alert]= I18n.t("fisheries.used_gears.exists")
      else
       @fishery.used_gears.push gear
       flash[:success]= I18n.t("fisheries.used_gears.created")
      end
      redisplay_used_gears
    else
      render js: "window.location = #{new_gear_path(fishery_id: params[:id], alpha_code: params[:get_gear]).to_json}"
    end

  end

  def delete_used_gear
    @fishery.used_gears.delete(Gear.find params[:used_gear])
    flash[:success]= I18n.t("fisheries.used_gear.removed")
    redisplay_used_gears
  end

  def add_member_company
    company = Company.find_by_name params[:get_company]
    if company
      if @fishery.member_companies.include?(company)
        flash[:alert]= I18n.t("fisheries.member_companies.exists")
      else
       @fishery.member_companies.push company
       flash[:success]= I18n.t("fisheries.member_companies.created")
      end
      redisplay_member_companies
    else

      render js: "window.location = #{new_company_path(fishery_id: params[:id], name: params[:get_company]).to_json}"
    end
  end

  def delete_member_company
    @fishery.member_companies.delete(Company.find params[:member_company])
    flash[:success]= I18n.t("fisheries.member_company.removed")
    redisplay_member_companies
  end

  def add_member_office
    office = Office.find_by_name params[:get_office]
    if office
      if @fishery.member_offices.include?(office)
        flash[:alert]= I18n.t("fisheries.member_offices.exists")
      else
       @fishery.member_offices.push office
       flash[:success]= I18n.t("fisheries.member_offices.created")
      end
      redisplay_member_offices
    else
      render js: "window.location = #{new_office_path(fishery_id: params[:id], name: params[:get_office]).to_json}"
    end
  end

  def delete_member_office
    @fishery.member_offices.delete(Office.find params[:member_office])
    flash[:success]= I18n.t("fisheries.member_office.removed")
    redisplay_member_offices
  end

  def report
    @fishery = Fishery.find(params[:id])
    #@chart = @fishery.surveys.group("DATE_TRUNC('month', survey.date_published)").order("DATE_TRUNC('month', survey.date_published)").average('landings.cpue_kg')
    #@chart = Hash[@chart.map { |k, v| [Time.parse(k).utc.to_i*1000, v.to_f.round(0)] }].to_a
    #respond_with(@fishery)
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
      format.xls {
        headers["Content-Disposition"] = "attachment; filename=\"#{@fishery.name}_#{Date.today}\""
      }
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

  private

  def set_fishery
    @fishery = Fishery.find(params[:id])
  end

  def fishery_params
    params.require(:fishery).permit(
      :code,
      :name
      )
  end

  def after_save_path_for(resource)
    fishery_path(resource)
  end

  def redisplay_target_fishes
    respond_to do |format|
      format.html { redirect_to @fishery }
      format.js { render :redisplay_target_fishes }
    end
  end

  def redisplay_bait_fishes
    respond_to do |format|
      format.html { redirect_to @fishery }
      format.js { render :redisplay_bait_fishes }
    end
  end

  def redisplay_used_gears
    respond_to do |format|
      format.html { redirect_to @fishery }
      format.js { render :redisplay_used_gears }
    end
  end

  def redisplay_member_companies
    respond_to do |format|
      format.html { redirect_to @fishery }
      format.js { render :redisplay_member_companies }
    end
  end

  def redisplay_member_offices
    respond_to do |format|
      format.html { redirect_to @fishery }
      format.js { render :redisplay_member_offices }
    end
  end

  def select_layout
    'application'
  end

end
