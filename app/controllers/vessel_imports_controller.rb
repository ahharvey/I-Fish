class VesselImportsController < ApplicationController
  
  respond_to :xls, only: [ :template ]

  def new
    @vessel_import = VesselImport.new
  end

  def create
#    params[:vessel_import], @currently_signed_in.id, @currently_signed_in.class.name
    @vessel_import = VesselImport.new( params[:vessel_import] )
    if @vessel_import.save(@currently_signed_in.id, @currently_signed_in.class.name )
      redirect_to root_url, notice: "Imported vessels successfully."
    else
      render :new
    end
  end



  def template
    @provinces = []
    respond_with(@provinces)
  end
end