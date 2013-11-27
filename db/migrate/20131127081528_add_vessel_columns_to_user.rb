class AddVesselColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :vessel_type_id, :integer
    add_column :users, :engine_id, :integer
    add_column :users, :power, :integer
    add_column :users, :length, :integer
    add_column :users, :notes, :text
  end
end
