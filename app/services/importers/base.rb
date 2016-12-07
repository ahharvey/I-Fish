module Importers

  class Base
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

    def call
      owner = imported_by
      if imported_rows.map(&:valid?).all?
        imported_rows.each do |row|

          whodunnit = "#{owner.class.name.to_s}:#{owner.id}" rescue 'Guest'
          row.paper_trail.whodunnit(whodunnit) do
            if row.is_a?(PendingVessel) && owner.is_a?(Admin)
              row.send("#{owner.class.name.underscore}_id=",owner_id)
            end
            if row.is_a?(Unloading)
              row.send("#{owner.class.name.underscore}_id=",owner.id)
              row.build_approved(owner) if owner.is_a?(Admin)
            end
            if row.is_a?(BaitLoading)
              row.build_approved(owner) if owner.is_a?(Admin)
            end
            row.save!
          end
          Activity.create! action: 'create', trackable: row, ownable_id: owner.id, ownable_type: owner.class.name
        end
        self.imported = true
        self
      else
        imported_rows.each_with_index do |row, index|
          row.errors.full_messages.each do |message|
            errors.add :base, "Row #{index+2}: #{message}"
          end
        end
        self.imported = false
        self
      end
    end

    def imported_rows
      @imported_rows ||= load_rows_from_spreadsheet
    end

    def persisted?
      false
    end

  private

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
