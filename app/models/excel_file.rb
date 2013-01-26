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
  after_initialize :set_excel_content
  after_save :save_excel_data
  validates :file, presence: true
  validate :validate_excel_data
  belongs_to :admin

  private

  def set_excel_content
    @excel_data = ExcelContentValidator.new
  end

  def validate_excel_data
    # Import and validate all data in the excel file
    ImportExcelData.working_based_sheet(self, @excel_data)

    if !@excel_data.models_valid?
      @excel_data.list_errors.each do |e|
        self.errors[:base] << e
      end
    end
  end

  def save_excel_data
    ActiveRecord::Base.transaction do
      binding.pry
      @excel_data.save_models!
    end
  end

  def update_asset_attributes
    if file.present? && file_changed?
      self.filesize = file.file.size
      self.filename = file.file.original_filename
    end
  end

  class ExcelContentValidator
    def initialize
      @models = []
    end

    def add_model(model, meta = {})
      # meta - sheet, model_type, row
      @models << { :model => model, :meta => meta }
    end

    def models_valid?
      @models.each { |m| return false if !m[:model].valid? }
      return true
    end

    def save_models!
      @models.each { |m| m[:model].save! }
    end

    # Aggregate errors into a list with meta data
    def list_errors
      error_messages = []
      @models.each do |m|
        if !m[:model].valid?
          m[:model].errors.each do |e|
            error_messages << "#{m[:meta][:sheet]}, row #{m[:meta][:row]} - #{e.to_s} #{m[:model].errors[e][0]}"
          end
        end
      end
      error_messages
    end
  end
end
