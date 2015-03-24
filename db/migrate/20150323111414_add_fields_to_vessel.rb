class AddFieldsToVessel < ActiveRecord::Migration
  def change
    add_column :vessels, :material_type, :string
    add_column :vessels, :machine_type, :string
    add_column :vessels, :capacity, :integer
    add_column :vessels, :vms, :boolean
    add_column :vessels, :tracker, :boolean
    add_column :vessels, :port, :string
  end
end
