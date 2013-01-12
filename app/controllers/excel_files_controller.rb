class ExcelFilesController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :xml, :json, :except => [ :edit, :new, :update, :create ]

  def show
  	@rspreadsheet = Excelx.new(@excel_file.file.url.to_s)
  end
end