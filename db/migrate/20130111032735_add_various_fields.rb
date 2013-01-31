class AddVariousFields < ActiveRecord::Migration
  def change
  	add_column :logged_days, :crew, :integer
  	add_column :logbooks, :fishery_id, :integer

  	add_column :landings, :fish_id, :integer
  	
  	add_column :provinces, :alpha_code, :string
  	
  	add_index :logbooks, :fishery_id
  	add_index :landings, :fish_id
  end
end
