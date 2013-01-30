class SurveyHasAdminNotUser < ActiveRecord::Migration
  def change
  	remove_column :surveys, :user_id
  	add_column :surveys, :admin_id, :integer
  end
end
