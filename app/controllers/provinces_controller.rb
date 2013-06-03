class ProvincesController < InheritedResources::Base
	load_and_authorize_resource

  respond_to :html, :xml, :json, :csv, :xls, :except => [ :edit, :new, :update, :create ]

  def show
    @province = Province.includes(:surveys, :landings => [ :catches ] ).find(params[:id])
    @districts = @province.districts.uniq
    @fisheries = @province.fisheries.uniq

#Product.joins(:shops).where(shops: { region_id: @region.id })
    
    @fishes = Fish.joins(:districts).where(districts: { province_id: @province.id }).uniq
#    @gears = Gear.joins(:districts).where(districts: { province_id: @province.id })
#    @fishes = @province.fishes.uniq
    @gears = @province.gears.uniq
    #@fishery_gears = Gear.joins(:fisheries).where(fisheries: { province: @province })


    @district_av_cpue_by_species = Landing.joins(:fish, :desa).average(:cpue, group: ['fishes.id', 'fishes.scientific_name', 'desas.district_id'])
    @district_av_cpue_by_gears = Landing.joins(:gear, :desa).average(:cpue, group: ['gears.id', 'gears.name', 'desas.district_id'])
    @fishery_av_cpue_by_species = Landing.joins(:fish, :survey).average(:cpue, group: ['fishes.id', 'fishes.scientific_name', 'surveys.fishery_id'])
    @fishery_av_cpue_by_gears = Landing.joins(:gear, :survey).average(:cpue, group: ['gears.id', 'gears.name', 'surveys.fishery_id'])

  	respond_to do |format|
      @date_from = (DateTime.now - 1.years).strftime("%d/%m/%Y")
      @date_to = DateTime.now.strftime("%d/%m/%Y")
  	  

      format.html { render }
      format.xml { render xml: @province.to_xml(include: { :surveys => {include: :landings => { include: :catches }}} ) }
      format.json { render json: @province.to_json(include: { :surveys => {include: :landings => { include: :catches }}} ) }
      format.csv { render text: @province.to_csv }
      format.xls
      format.pdf {
        render :pdf => "Province_#{@province.name}_#{DateTime.now.strftime('%Y#m')}", 
        :header => { 
          :font_size => '8', 
          :right => "FishNet | Province Report"
        }, 
        :footer => {
          :font_size => '8', 
          :right => '[page] of [toPage]' 
        }
      }

  	end
  end
	
end
