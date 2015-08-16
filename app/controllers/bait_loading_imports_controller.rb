class BaitLoadingImportsController < ApplicationController
  
  respond_to :xls, only: [ :template ]

  def new
    @bait_loading_import = Importer.new
    #@unloading_import = Importer.new.file
    #@unloading_import.success_action_redirect = new_unloading_import_path
  end

  def template
    @provinces = []
    respond_with(@provinces)
  end
end