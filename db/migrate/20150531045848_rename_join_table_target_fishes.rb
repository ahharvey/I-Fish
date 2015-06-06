class RenameJoinTableTargetFishes < ActiveRecord::Migration
  def self.up
    rename_table :fisheries_fishes, :target_fishes
  end

 def self.down
    rename_table :target_fishes, :fisheries_fishes
 end
end
