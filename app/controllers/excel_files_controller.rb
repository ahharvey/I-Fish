
class ExcelFilesController < ApplicationController
  load_and_authorize_resource

  before_action :set_excel_file, only: [:show, :edit, :update, :destroy]
  respond_to :html
  respond_to :xml, :json, :except => [ :edit, :new, :update, :create ]

  def index
    @excel_files = ExcelFile.all
    respond_with(@excel_files)
  end

  def show
    require 'roo'
    @excel_file = ExcelFile.find(params[:id])
    @file = @excel_file.file.url
    @rspreadsheet = Roo::Spreadsheet.open(@file) #Excelx.new("http://i-fish.dev/uploads/excel_file/file/7/Database.template__3_.xlsx")#
    respond_with(@excel_file)
  end

  def new
    @excel_file = ExcelFile.new
    respond_with(@excel_file)
  end

  def edit
  end

  def create
    @excel_file = ExcelFile.new(excel_file_params)
    @excel_file.save
    respond_with @excel_file, location: -> { after_save_path_for(@excel_file) }
  end

  def update
    @excel_file.update(excel_file_params)
    respond_with @excel_file, location: -> { after_save_path_for(@excel_file) }
  end

  def destroy
    @excel_file.destroy
    respond_with(@excel_file)
  end

  private
  
  def set_excel_file
    @excel_file = ExcelFile.find(params[:id])
  end

  def excel_file_params
    params.require(:excel_file).permit(
      :file, 
      :filename, 
      :filesize, 
      :admin_id
      )
  end

  def after_save_path_for(resource)
    excel_file_path(resource)
  end

end


