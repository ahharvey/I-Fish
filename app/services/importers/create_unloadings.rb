module Importers
  class CreateUnloadings < Base

  private

    def load_rows_from_spreadsheet
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

  end
end
