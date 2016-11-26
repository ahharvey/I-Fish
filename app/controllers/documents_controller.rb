class DocumentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_document, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :csv, :xls, :js, :except => [ :edit, :new, :update, :create ]

  def index
    @documents = Document.default
    respond_to do |format|
      format.html
    end
  end

  def show
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    Rails.logger.info 'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'
    Rails.logger.info Document.all.size
    @document = Document.new(document_params)
    Rails.logger.info @document.valid?
    Rails.logger.info @document.to_yaml
    respond_to do |format|
      if @document.save
        Rails.logger.info Document.all.size
        format.html { redirect_to @document.documentable, notice: t('.notice') }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document.documentable, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    documentable = @document.documentable
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documentable, notice: t('.notice') }
      format.json { head :no_content }
    end
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
    polymorphic_path(resource.documentable)
  end

end
