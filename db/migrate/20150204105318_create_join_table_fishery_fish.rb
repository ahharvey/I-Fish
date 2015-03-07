class CreateJoinTableFisheryFish < ActiveRecord::Migration
  def up
    create_table :fisheries_fishes, :id => false do |t|
      t.references :fishery, :fish
    end
  end

  def down
    drop_table :fisheries_fishes
  end
end
