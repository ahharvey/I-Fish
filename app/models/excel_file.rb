# == Schema Information
#
# Table name: excel_files
#
#  id         :integer          not null, primary key
#  filename   :string(255)
#  filesize   :string(255)
#  file       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :integer
#

require 'import_excel_data'

class ExcelFile < ActiveRecord::Base
  attr_accessible :file, :filename, :filesize, :admin_id
  before_save :update_asset_attributes
  mount_uploader :file, ExcelFileUploader
  after_save :import_excel_data
  validates :file, presence: true
  belongs_to :admin

  private

  def import_excel_data
    ActiveRecord::Base.transaction do
      ImportExcelData.working_based_sheet(self.id, self.admin_id)
    end
  end

  def update_asset_attributes
    if file.present? && file_changed?
      self.filesize = file.file.size
      self.filename = file.file.original_filename
    end
  end
end
