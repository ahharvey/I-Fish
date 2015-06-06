class VesselImport
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
    if imported_vessels.map(&:valid?).all?
      imported_vessels.each do |vessel|
        vessel.save!
        Activity.create! action: 'create', trackable: vessel, ownable_id: owner_id, ownable_type: owner_type
      end
      true
    else
      imported_vessels.each_with_index do |vessel, index|
        vessel.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_vessels
    @imported_vessels ||= load_imported_vessels
  end

  def load_imported_vessels
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      vessel = Vessel.find_by_id(row["id"]) || Vessel.new
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
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, csv_options: {col_sep: ";"})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end