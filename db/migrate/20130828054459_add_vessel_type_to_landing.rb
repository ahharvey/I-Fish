class AddVesselTypeToLanding < ActiveRecord::Migration
  def change
    add_column :landings, :vessel_type_id, :integer
    add_index :landings, :vessel_type_id
  end
end
