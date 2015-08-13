class UnloadingImportsController < ApplicationController
  
  respond_to :xls, only: [ :template ]

  def new
    @unloading_import = Importer.new
    #@unloading_import = Importer.new.file
    #@unloading_import.success_action_redirect = new_unloading_import_path
  end

  def create
    UnloadingImporterJob.perform_now( @currently_signed_in.id, @currently_signed_in.class.name, params[:unloading_import] )
    redirect_to new_unloading_import_path, notice: "Imported unloadings successfully."
#    @unloading_import = UnloadingImport.new( params[:unloading_import] )
#    if @unloading_import.save(@currently_signed_in.id, @currently_signed_in.class.name )
#      redirect_to root_url, notice: "Imported unloadings successfully."
#    else
#      render :new
#    end
  end



  def template
    @provinces = []
    respond_with(@provinces)
  end
end