class ImportersController < ApplicationController

  load_and_authorize_resource

  before_action :set_importer, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]
  responders :flash

  def index
    @importers = Importer.all
    respond_with(@importers)
  end

  def show
    respond_with(@importer)
  end

  def new
    @importer = Importer.new
    respond_with(@importer)
  end

  def edit
  end

  def create
    @importer = Importer.new(importer_params)
    if @importer.save
	    UnloadingImporterJob.perform_later( @currently_signed_in.id, @currently_signed_in.class.name, @importer.id )
	    #UnloadingImporterJob.perform_later( 64, 'Admin', @importer.id )
	  end
    respond_with @importer, location: -> { after_save_path_for(@importer) }
  end

  def update
    @importer.update(importer_params)
    respond_with @importer, location: -> { after_save_path_for(@importer) }
  end

  def destroy
    @importer.destroy
    respond_with(@importer)
  end

  private
  
  def set_importer
    @importer = Importer.find(params[:id])
  end

  def importer_params
    params.require(:importer).permit(
      :file,
      :label
      )
  end

  def after_save_path_for(resource)
  	if resource.label == 'unloadings'
  		#flash[:success] = "Your file was uploaded successfully and is being processed. We'll send you an email when it's finished."
  		new_unloading_import_path

  	else
	    importer_path(resource)
	  end
  end

  def interpolation_options
    { notification_email: @currently_signed_in.email }
  end

end

