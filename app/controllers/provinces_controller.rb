class ProvincesController < InheritedResources::Base
	load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def show
  	respond_to do |format|
      @date_from = (DateTime.now - 1.years).strftime("%d/%m/%Y")
      @date_to = DateTime.now.strftime("%d/%m/%Y")
  	  @province = Province.includes(:surveys, :landings).find(params[:id])

      format.html { render }
      format.xml { render xml: @province.to_xml(include: { :surveys => {include: :landings}} ) }
      format.json { render json: @province.to_json(include: { :surveys => {include: :landings}} ) }
  	end
  end
	
end
