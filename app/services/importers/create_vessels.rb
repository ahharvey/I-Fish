module Importers
  class CreateVessels < Base

  private

    def load_rows_from_spreadsheet
      spreadsheet = open_spreadsheet
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        vessel = Vessel.find_by_id(row["id"]) || Vessel.new
        vessel.attributes = row.to_hash.slice(*Vessel.accessible_attributes)
        vessel.company_id = parent.id if parent.is_a?(Company)
        vessel
      end
    end

  end
end
