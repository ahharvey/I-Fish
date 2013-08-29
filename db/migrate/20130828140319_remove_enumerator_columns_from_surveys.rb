class RemoveEnumeratorColumnsFromSurveys < ActiveRecord::Migration
  def up
    remove_column :surveys, :catch_scribe
    remove_column :surveys, :catch_measure
    remove_column :surveys, :fleet_observer
  end

  def down
    add_column :surveys, :catch_scribe, :string
    add_column :surveys, :catch_measure, :string
    add_column :surveys, :fleet_observer, :string
  end
end
