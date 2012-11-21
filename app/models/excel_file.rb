require 'import_excel_data'
class ExcelFile < ActiveRecord::Base
  attr_accessible :file, :filename, :filesize
  before_save :update_asset_attributes
  after_create :invoke_to_db
  mount_uploader :file, ExcelFileUploader
  
  private
  
  def invoke_to_db
    ImportExcelData.working_based_sheet(self.id)
  end
  
  def update_asset_attributes
    if file.present? && file_changed?
      self.filesize = file.file.size
      self.filename = file.file.original_filename
    end
  end
end
