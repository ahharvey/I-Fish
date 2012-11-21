class ExcelFile < ActiveRecord::Base
  attr_accessible :file, :filename, :filesize
  before_save :update_asset_attributes
  mount_uploader :file, ExcelFileUploader
  
  private
  
  def update_asset_attributes
    if file.present? && file_changed?
      self.filesize = file.file.size
      self.filename = file.file.original_filename
    end
  end
end
