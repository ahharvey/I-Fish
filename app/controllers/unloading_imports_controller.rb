class UnloadingImportsController < ApplicationController
  
  respond_to :xls, only: [ :template ]

  def new
    @unloading_import = UnloadingImport.new
  end

  def create

    @unloading_import = UnloadingImport.new( params[:unloading_import] )
    if @unloading_import.save(@currently_signed_in.id, @currently_signed_in.class.name )
      redirect_to root_url, notice: "Imported unloadings successfully."
    else
      render :new
    end
  end



  def template
    @provinces = []
    respond_with(@provinces)
  end
end