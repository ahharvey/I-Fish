class AddApprovedToLogbook < ActiveRecord::Migration
  def self.up
  	add_column :logbooks, :approver_id, :integer
  	add_column :logbooks, :approved, :boolean, :default => false, :null => false
  	add_index  :logbooks, :approver_id
  	add_index  :logbooks, :approved
  end

  def self.down
  	remove_index  :logbooks, :approver_id
  	remove_index  :logbooks, :approved
  	remove_column :surveys, :approver_id
		remove_column :logbooks, :approved
  end
end
