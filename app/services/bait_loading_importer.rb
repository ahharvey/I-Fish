class BaitLoadingImporter
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
      imported_rows.each do |bait_loading|
        # UnloadingSaverJob.perform_later(unloading, owner_id, owner_type)
        whodunnit = "#{owner_type.to_s}:#{owner_id}" rescue 'Guest'
        bait_loading.whodunnit(whodunnit) do
          bait_loading.approve!
          if owner_type.to_s == 'Admin'
            bait_loading.reviewer_id = owner_id
          end
          bait_loading.save!
        end
        Activity.create! action: 'create', trackable: bait_loading, ownable_id: owner_id, ownable_type: owner_type
      end
      true
    else
      imported_rows.each_with_index do |bait_loading, index|
        bait_loading.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
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
