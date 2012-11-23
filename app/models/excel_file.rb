require 'import_excel_data'

class ExcelFile < ActiveRecord::Base
  attr_accessible :file, :filename, :filesize
  before_save :update_asset_attributes
  mount_uploader :file, ExcelFileUploader
  after_save :import_excel_data
  validates :file, presence: true


  private
  
  def import_excel_data
    ImportExcelData.working_based_sheet(self.id)  
  end
  
  def update_asset_attributes
    if file.present? && file_changed?
      self.filesize = file.file.size
      self.filename = file.file.original_filename
    end
  end
end