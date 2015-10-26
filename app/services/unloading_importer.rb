class UnloadingImporter
  # switch to ActiveModel::Model in Rails 4
  include ActiveModel::Model
  #extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save( owner_id, owner_type)
    owner = owner_type.constantize.find owner_id
    if imported_unloadings.map(&:valid?).all?
      imported_unloadings.each do |unloading|
        # UnloadingSaverJob.perform_later(unloading, owner_id, owner_type)
        whodunnit = "#{owner_type.to_s}:#{owner_id}" rescue 'Guest'
        unloading.whodunnit(whodunnit) do 
          unloading.send("#{owner_type.underscore}_id=",owner_id)
          unloading.approved!
          if owner_type.to_s == 'Admin'
            unloading.reviewer_id = owner_id
          end
          unloading.save!
        end
        Activity.create! action: 'create', trackable: unloading, ownable_id: owner_id, ownable_type: owner_type
      end
      true
    else
      imported_unloadings.each_with_index do |unloading, index|
        unloading.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_unloadings
    @imported_unloadings ||= load_imported_unloadings
  end

  def load_imported_unloadings
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      unloading = Unloading.find_by_id(row["id"]) || Unloading.new
      unloading.attributes = row.to_hash.slice(*( Unloading.accessible_attributes - ['yft_kg', 'skj_kg', 'bet_kg', 'komu_kg', 'kaw_kg'] ) )

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