class ExcelFilesController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def show
    require 'roo'
    @excel_file = ExcelFile.find(params[:id])
    @file = File.join(Rails.root, @excel_file.file.url.to_s)
    @rspreadsheet = Roo:Spreadsheet.open(@file) #Excelx.new("http://i-fish.dev/uploads/excel_file/file/7/Database.template__3_.xlsx")#
  end
end