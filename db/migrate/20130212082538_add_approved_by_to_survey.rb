class AddApprovedByToSurvey < ActiveRecord::Migration
  def self.up
  	add_column :surveys, :approver_id, :integer
  	add_index  :surveys, :approver_id
  end

  def self.down
  	remove_index  :surveys, :approver_id
  	remove_column :surveys, :approver_id
  end
end
