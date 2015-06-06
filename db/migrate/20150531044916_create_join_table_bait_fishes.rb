class CreateJoinTableBaitFishes < ActiveRecord::Migration
  def change
    create_join_table :fisheries, :fish, table_name: :bait_fishes do |t|
      t.index [:fishery_id, :fish_id]
      t.index [:fish_id, :fishery_id]
    end
  end
end
