class AddVesselCountToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :vessel_count, :integer
  end
end
