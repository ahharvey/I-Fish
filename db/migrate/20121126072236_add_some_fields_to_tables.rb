class AddSomeFieldsToTables < ActiveRecord::Migration
  def change
    add_column :excel_files, :user_id, :integer
    add_column :desas, :kabupaten, :string
    add_column :surveys, :fishery_id, :integer
    add_column :landings, :type, :string
    remove_column :surveys, :observer
    remove_column :surveys, :scribe
    remove_column :surveys, :measure
    add_column :surveys, :fleet_observer, :string
    add_column :surveys, :catch_scribe, :string
    add_column :surveys, :catch_measure, :string
  end
end
