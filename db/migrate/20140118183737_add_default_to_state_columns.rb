class AddDefaultToStateColumns < ActiveRecord::Migration
  def change
    change_column :surveys, :review_state, :string, default: 'pending'
    change_column :logbooks, :review_state, :string, default: 'pending'
  end
end
