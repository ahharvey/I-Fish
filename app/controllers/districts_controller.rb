class DistrictsController < InheritedResources::Base
	load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def show
  	@district = District.includes(:surveys, :landings).find(params[:id])
  	respond_to do |format|
  		format.html { render }
  		format.xml { render xml: @district.to_xml(include: { :surveys => {include: :landings}} ) }
      format.json { render json: @district.to_json(include: { :surveys => {include: :landings}} ) }
      format.csv { render text: @district.to_csv }
      format.xls
      format.pdf {
        render :pdf => "District_#{@district.name}_#{DateTime.now.strftime('%Y#m')}", 
        :header => { 
          :font_size => '8', 
          :right => "FishNet | District Report"
        }, 
        :footer => {
          :font_size => '8', 
          :right => '[page] of [toPage]' 
        }
      }
    end
  end
end
