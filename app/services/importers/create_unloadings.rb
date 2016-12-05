module Importers
  class CreateUnloadings
    # switch to ActiveModel::Model in Rails 4
    include ActiveModel::Model
    #extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_accessor :file, :imported_by, :parent, :imported

    def initialize(attributes = {})
      attributes.each { |name, value| send("#{name}=", value) }
    end

    def persisted?
      false
    end

    def call
      owner = imported_by
      if imported_rows.map(&:valid?).all?
        imported_rows.each do |unloading|
          # UnloadingSaverJob.perform_later(unloading, owner_id, owner_type)
          whodunnit = "#{owner.class.name.to_s}:#{owner.id}" rescue 'Guest'
          unloading.paper_trail.whodunnit(whodunnit) do
            unloading.send("#{owner.class.name.underscore}_id=",owner.id)
            unloading.build_approved(owner) if owner.is_a?(Admin)
            unloading.save!
          end

          Activity.create! action: 'create', trackable: unloading, ownable_id: owner.id, ownable_type: owner.class.name
        end
        self.imported = true
        self
      else
        imported_rows.each_with_index do |unloading, index|
          unloading.errors.full_messages.each do |message|
            errors.add :base, "Row #{index+2}: #{message}"
          end
        end
        self.imported = false
        self
      end
    end

    def imported_rows
      @imported_unloadings ||= load_imported_unloadings
    end

    def load_imported_unloadings
      spreadsheet = open_spreadsheet
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        unloading = Unloading.find_by_id(row["id"]) || Unloading.new
        unloading.attributes = row.to_hash.slice(*( Unloading.accessible_attributes - ['yft_kg', 'skj_kg', 'bet_kg', 'komu_kg', 'kaw_kg'] ) )
        unloading.vessel_id = parent.id if parent.is_a?(Vessel)
        unloading.wpp_code = row["wpp_code"].to_s
        unloading.port_code = row["port_code"].to_s
  #      #convert date to correct format
  #      unloading.time_out = DateTime.new(1899, 12, 30) + row["time_out"]
  #      unloading.time_in  = DateTime.new(1899, 12, 30) + row["time_in"]

        #add catch data
        row.to_hash.slice(*['yft_kg', 'skj_kg', 'bet_kg', 'komu_kg', 'kaw_kg'] ).each do |sp_catch|
          unless sp_catch[1].nil? || sp_catch[1] == 0
            Rails.logger.info sp_catch
            unloading.send(sp_catch[0]+'=', sp_catch[1])
          end
        end
        unloading
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
