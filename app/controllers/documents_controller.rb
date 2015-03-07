class DocumentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_document, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @documents = Document.all
    respond_with(@documents)
  end

  def show
    respond_with(@document)
  end

  def new
    @document = Document.new
    respond_with(@document)
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    @Document.save
    respond_with @document, location: -> { after_save_path_for(@document) }
  end

  def update
    @document.update(document_params)
    respond_with @document, location: -> { after_save_path_for(@document) }
  end

  def destroy
    @document.destroy
    respond_with(@document)
  end

  private
  
  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(
      :title, 
      :description, 
      :file, 
      :content_type, 
      :file_size, 
      :documentable_id, 
      :documentable_type
      )
  end

  def after_save_path_for(resource)
    document_path(resource)
  end

end



