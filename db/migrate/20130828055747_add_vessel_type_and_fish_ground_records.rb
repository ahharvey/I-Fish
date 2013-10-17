class AddVesselTypeAndFishGroundRecords < ActiveRecord::Migration
  def up
    codes = ["51.1","51.2","51.3","51.4","51.5","51.6","51.7","51.8","51a","51b","52.1","52.2","52.3","52.4","52.5","52a","52b"]
    codes.map{ |code| Graticule.find_or_create_by_code(code) }

    vessel_types = ["oc"]
    vessel_types.map{ |vessel_type| VesselType.find_or_create_by_code(vessel_type) }
  end

  def down
  end
end
