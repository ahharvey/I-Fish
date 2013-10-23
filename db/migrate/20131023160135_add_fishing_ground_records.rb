class AddFishingGroundRecords < ActiveRecord::Migration
  def up
    codes = ["LOM-1", "LOM-2", "LOM-3", "LOM-4", "LOM-5", "LOM-6", "BAL-1", "SUM-1", "UTA", "SEL"]

    for code in codes
      Graticule.create( code: code )
    end
  end

  def down
  end
end
