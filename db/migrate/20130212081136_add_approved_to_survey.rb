class AddApprovedToSurvey < ActiveRecord::Migration
  
  def self.up
  	add_column :surveys, :approved, :boolean, :default => false, :null => false
    add_index  :surveys, :approved
  end

  def self.down
    remove_index  :surveys, :approved
    remove_column :surveys, :approved
  end
end
