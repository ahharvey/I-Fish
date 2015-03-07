


class ProvincesController < ApplicationController
  load_and_authorize_resource

  before_action :set_province, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @provinces = Province.all
    respond_with(@provinces)
  end

  def show
    # respond_with(@province)
    @province = Province.includes(:surveys, :gears, :fishes, :districts, :fisheries, :landings => [ :catches ] ).find(params[:id])
    @districts = @province.districts.uniq
    @fisheries = @province.fisheries.uniq

#Product.joins(:shops).where(shops: { region_id: @region.id })
    
    @fishes = @province.fishes.uniq
    #Fish.joins(:districts).where(districts: { province_id: @province.id }).uniq
#    @gears = Gear.joins(:districts).where(districts: { province_id: @province.id })
#    @fishes = @province.fishes.uniq
    @gears = @province.gears.uniq
    #@fishery_gears = Gear.joins(:fisheries).where(fisheries: { province: @province })

    if params.has_key?(:province)
      start_date = Date.new(params[:province][:year].to_i).beginning_of_year
      end_date = Date.new(params[:province][:year].to_i).end_of_year
      @test_date = params[:province][:year]
      @test_year = params[:province][:year]
    else
      @test_date = "no date"
      @test_year = "no year"
    #else
      start_date = Date.today.beginning_of_year
      end_date = Date.today.end_of_year
    end

    
        

    #@district_av_cpue_by_species = Landing.joins(:fish, :desa).average(:cpue, group: ['fishes.id', 'fishes.scientific_name', 'desas.district_id'])
    #@district_av_cpue_by_gears = Landing.joins(:gear, :desa).average(:cpue, group: ['gears.id', 'gears.name', 'desas.district_id'])
    #@fishery_av_cpue_by_species = Landing.joins(:fish, :survey).average(:cpue, group: ['fishes.id', 'fishes.scientific_name', 'surveys.fishery_id'])
    #@fishery_av_cpue_by_gears = Landing.joins(:gear, :survey).average(:cpue, group: ['gears.id', 'gears.name', 'surveys.fishery_id'])

    @district_av_cpue_by_species = Landing
      .joins(:fish, :district, :survey)
      .where('surveys.date_published between ? AND ?', start_date, end_date)
      .average(:cpue, group: ['districts.id', 'districts.name', 'fishes.id'])
    @district_av_cpue_by_gears = Landing
      .joins(:gear, :district, :survey)
      .where('surveys.date_published between ? AND ?', start_date, end_date)
      .average(:cpue, group: ['districts.id', 'districts.name', 'gears.id'])
    @fishery_av_cpue_by_species = Landing
      .joins(:fish, :fishery, :survey)
      .where('surveys.date_published between ? AND ?', start_date, end_date)
      .average(:cpue, group: ['fisheries.id', 'fisheries.name', 'fishes.id'])
    @fishery_av_cpue_by_gears = Landing
      .joins(:gear, :fishery, :survey)
      .where('surveys.date_published between ? AND ?', start_date, end_date)
      .average(:cpue, group: ['fisheries.id', 'fisheries.name', 'gears.id'])

    respond_to do |format|
      @date_from = (DateTime.now - 1.years).strftime("%d/%m/%Y")
      @date_to = DateTime.now.strftime("%d/%m/%Y")
      

      format.html { render }
      format.xml { render xml: @province.to_xml(include: { :surveys => {include: { :landings => { include: :catches }}}} ) }
      format.json { render json: @province.to_json(include: { :surveys => {include: { :landings => {include: :catches }}}} ) }
      format.csv { render text: @province.to_csv }
      format.xls
      format.js
      format.pdf {
        render :pdf => "Province_#{@province.name}_#{DateTime.now.strftime('%Y#m')}", 
        :header => { 
          :font_size => '8', 
          :right => "Province Report | I-Fish"
        }, 
        :footer => {
          :font_size => '8', 
          :right => '[page] of [toPage]' 
        }
      }
    end
  end

  def new
    @province = Province.new
    respond_with(@province)
  end

  def edit
  end

  def create
    @province = Province.new(province_params)
    @province.save
    respond_with @province, location: -> { after_save_path_for(@province) }
  end

  def update
    @province.update(province_params)
    respond_with @province, location: -> { after_save_path_for(@province) }
  end

  def destroy
    @province.destroy
    respond_with(@province)
  end

  private
  
  def set_province
    @province = Province.find(params[:id])
  end

  def vessel_params
    params.require(:vessel).permit(
      :name, 
      :code, 
      :year
      )
  end

  def after_save_path_for(resource)
    province_path(resource)
  end

end


