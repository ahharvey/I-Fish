module Importers
  class CreateBaitLoadings < Base

  private

    def load_rows_from_spreadsheet
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

  end
end
