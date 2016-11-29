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

class ExcelFile < ApplicationRecord

  before_validation :import_excel_data
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

  def import_excel_data
    # Import all data in the excel file
    ImportExcelData.working_based_sheet(self, @excel_data)
  end

  def validate_excel_data
    if !@excel_data.models_valid?
      @excel_data.list_errors.each do |e|
        self.errors[:base] << e
      end
    end
  end

  def save_excel_data
    ActiveRecord::Base.transaction do
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
      Rails.logger.info @models.to_yaml
      puts @models.to_yaml
      # We need to save the survey first if it exists and then add each of the landings to it
      for survey in @models.select{|m| m[:model].is_a? Survey}
        survey = survey[:model]
        Rails.logger.info survey.to_yaml
        puts survey.to_yaml
        PaperTrail.whodunnit = survey.admin_id
        survey.save!

      end

      for landing in @models.select{|m| m[:model].is_a? Landing}
        landing = landing[:model]
        landing.survey_id = Survey.last.id
        Rails.logger.info landing.to_yaml
        puts landing.to_yaml
        PaperTrail.whodunnit = landing.survey.admin_id
        landing.save!
        Rails.logger.info "#############################"
        puts "#############################"
      end

      for catch_tab in @models.select{|m| m[:model].is_a? Catch}
        catch_tab = catch_tab[:model]
        landing = Landing.where(survey_id: survey.id, row: catch_tab.row).first
        catch_tab.landing_id = landing.id
        Rails.logger.info catch_tab.to_yaml
        puts catch_tab.to_yaml
        PaperTrail.whodunnit = catch_tab.survey.admin_id
        catch_tab.save!

      end





#        @models.select{|m| m[:model].is_a? Landing}.each do |l|
#          l[:model].survey = survey
#          Rails.logger.info l[:model].to_yaml
#          puts l[:model].to_yaml
#        end
#        @models.select{|m| m[:model].is_a? Catch}.each do |c|
#          landing = Landing.where(survey_id: survey.id, row: c[:model].row )
#          Rails.logger.info c[:model].row
#          c[:model].landing = landing
#          Rails.logger.info c[:model].to_yaml
#          puts c[:model].to_yaml
#        end


      # We need to save the logbook first if it exists and then add each of the landings to it
      if @models.select{|m| m[:model].is_a? Logbook}.count > 0
        logbook = @models.select{|m| m[:model].is_a? Logbook}.first[:model]
        logbook.save!
        @models.select{|m| m[:model].is_a? LoggedDay}.each do |l|
          l = l[:model]
          l.logbook_id = logbook.id
          PaperTrail.whodunnit = logbook.user_id
          l.save!
        end
      end

      #@models.each { |m| m[:model].save! }
    end

    # Aggregate errors into a list with meta data
    def list_errors
      error_messages = []
      @models.each do |m|
        if !m[:model].valid?
          m[:model].errors.each do |e|
            error_messages << "#{e.to_s.titlecase} #{m[:model].errors[e][0]} - #{m[:meta][:sheet]}, row #{m[:meta][:row] or 'N/A'}"
          end
        end
      end
      error_messages
    end
  end
end
