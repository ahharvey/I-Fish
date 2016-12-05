module Importers
  class CreateBaitLoadings
    # switch to ActiveModel::Model in Rails 4
    include ActiveModel::Model
    #extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_accessor :file, :imported_by, :parent, :imported

    attr_reader   :errors

    def initialize(attributes = {})
      attributes.each { |name, value| send("#{name}=", value) }
      @errors = ActiveModel::Errors.new(self)
    end

    def persisted?
      false
    end

    def call
      owner = imported_by
      if imported_rows.map(&:valid?).all?
        imported_rows.each do |bait_loading|
          # UnloadingSaverJob.perform_later(unloading, owner_id, owner_type)
          whodunnit = "#{owner.class.name.to_s}:#{owner.id}" rescue 'Guest'
          bait_loading.paper_trail.whodunnit(whodunnit) do
            bait_loading.build_approved(owner) if owner.is_a?(Admin)
            bait_loading.save!
          end
          Activity.create! action: 'create', trackable: bait_loading, ownable_id: owner.id, ownable_type: owner.class.name
        end
        self.imported = true
        self
      else
        imported_rows.each_with_index do |bait_loading, index|
          bait_loading.errors.full_messages.each do |message|
            errors.add :base, "Row #{index+2}: #{message}"
          end
        end
        #false
        self.imported = false
        self
      end
    end

    def imported_rows
      @imported_bait_loadings ||= load_imported_bait_loadings
    end

    def load_imported_bait_loadings
      spreadsheet = open_spreadsheet
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        bait_loading = BaitLoading.find_by_id(row["id"]) || BaitLoading.new
        bait_loading.attributes = row.to_hash.slice(*( BaitLoading.accessible_attributes ) )
        bait_loading.quantity = bait_loading.quantity.to_i
        bait_loading.vessel_id = parent.id if parent.is_a?(Vessel)
        bait_loading.bait_code = row["bait_code"]
        bait_loading.secondary_bait_code = row["secondary_bait_code"]
        bait_loading
      end
    end

  #  def open_spreadsheet
  #    case File.extname(file.original_filename)
  #    when ".csv" then Csv.new(file.path, nil, :ignore)
  #    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  #    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  #    else raise "Unknown file type: #{file.original_filename}"
  #    end
  #  end

    def open_spreadsheet
      case File.extname(file.file.filename)
      when ".csv" then Roo::Csv.new(file.url, csv_options: {col_sep: ";"})
      when ".xls" then Roo::Excel.new(file.url)
      when ".xlsx" then Roo::Excelx.new(file.url)
      else raise "Unknown file type: #{file.file.filename}"
      end
    end
  end
end
