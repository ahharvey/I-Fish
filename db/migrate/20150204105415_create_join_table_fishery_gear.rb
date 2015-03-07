class CreateJoinTableFisheryGear < ActiveRecord::Migration
  def up
    create_table :fisheries_gears, :id => false do |t|
      t.references :fishery, :gear
    end
  end

  def down
    drop_table :fisheries_gears
  end
end


