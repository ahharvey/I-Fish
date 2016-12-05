class ImportersController < ApplicationController

  load_and_authorize_resource

  #before_action :set_importer, only: [:show, :edit, :update, :destroy]

#  respond_to :html
#  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]
#  responders :flash

  def index
    @importers = Importer.default
  end

#  def show
#    respond_with(@importer)
#  end

  def new
    if params[:label].present? && ['vessels', 'unloadings', 'bait_loadings'].include?( params[:label] )
      @label    = params[:label]
      @importer = Importer.new(label: @label )
    else
      @label    = nil
      @importer = nil
    end
    fetch_parent
  end

#  def edit
#  end

  def create
    @importer = Importer.new(importer_params)
    @importer.parent = fetch_parent
    @importer.imported_by = @currently_signed_in
    respond_to do |format|
      if @importer.save
        UnloadingImporterJob.perform_later( @importer.id )
        format.html { redirect_to @object, notice: t('.notice') }
        format.json { render :show, status: :created, location: @importer }
      else
        format.html { render :new }
        format.json { render json: @importer.errors, status: :unprocessable_entity }
      end
    end
  end

#  def update
#    @importer.update(importer_params)
#    respond_with @importer, location: -> { after_save_path_for(@importer) }
#  end

#  def destroy
#    @importer.destroy
#    respond_with(@importer)
#  end

private

#  def set_importer
#    @importer = Importer.find(params[:id])
#  end

  def importer_params
    params.require(:importer).permit(
      :file,
      :label
      )
  end

#  def after_save_path_for(resource)
#    if resource.label == 'unloadings'
#      #flash[:success] = "Your file was uploaded successfully and is being processed. We'll send you an email when it's finished."
#      new_unloading_import_path
#    elsif resource.label == 'bait_loadings'
#      #flash[:success] = "Your file was uploaded successfully and is being processed. We'll send you an email when it's finished."
#      new_bait_loading_import_path
#    elsif resource.label == 'vessels'
#      #flash[:success] = "Your file was uploaded successfully and is being processed. We'll send you an email when it's finished."
#      new_vessel_import_path
#    else
#      importer_path(resource)
#    end
#  end

#  def interpolation_options
#    { notification_email: @currently_signed_in.email }
#  end

  def fetch_parent
    if klass = [Company,Vessel].detect { |k| params["#{k.name.underscore}_id"]}
      @object = klass.find( params["#{klass.name.underscore}_id"] ) rescue nil
    else
      @object = nil
    end
  end

end
