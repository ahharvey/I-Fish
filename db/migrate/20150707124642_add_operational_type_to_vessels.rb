class AddOperationalTypeToVessels < ActiveRecord::Migration
  def change
    add_column :vessels, :operational_type, :string
    add_column :pending_vessels, :operational_type, :string
  end
end
