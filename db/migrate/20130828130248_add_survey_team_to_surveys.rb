class AddSurveyTeamToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :landing_enumerator_id, :integer
    add_column :surveys, :catch_measurer_id, :integer
    add_column :surveys, :catch_scribe_id, :integer

    add_index :surveys, :landing_enumerator_id
    add_index :surveys, :catch_measurer_id
    add_index :surveys, :catch_scribe_id

  end
end
