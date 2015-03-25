class AddPvrFieldsToVessel < ActiveRecord::Migration
  def change
    add_column :vessels, :name_changed, :boolean
    add_column :vessels, :flag_state_changed, :boolean
    add_column :vessels, :radio, :boolean
    add_column :vessels, :relationship_type, :string
  end
end
