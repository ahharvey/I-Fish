class DistrictsController < InheritedResources::Base
	load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def show
  	@district = District.includes(:surveys, :landings).find(params[:id])
  	respond_to do |format|
  		format.html { render }
  		format.xml { render xml: @district.to_xml(include: { :surveys => {include: :landings}} ) }
      format.json { render json: @district.to_json(include: { :surveys => {include: :landings}} ) }
    end
  end
end
