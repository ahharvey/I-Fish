class VesselImporter
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
    if imported_rows.map(&:valid?).all?
      imported_rows.each do |vessel|

        whodunnit = "#{owner_type.to_s}:#{owner_id}" rescue 'Guest'
        vessel.whodunnit(whodunnit) do
          if vessel.class.name == 'PendingVessel' && owner_type == 'Admin'
            vessel.send("#{owner_type.underscore}_id=",owner_id)
          end
          vessel.save!
        end
        Activity.create! action: 'create', trackable: vessel, ownable_id: owner_id, ownable_type: owner_type
      end
      true
    else
      imported_rows.each_with_index do |vessel, index|
        vessel.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end


  def imported_rows
    @imported_vessels ||= load_imported_vessels
  end

  def load_imported_vessels
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      vessel = Vessel.find_by_id(row["id"]).pending_vessel || Vessel.new
      vessel.attributes = row.to_hash.slice(*Vessel.accessible_attributes)
      vessel
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
