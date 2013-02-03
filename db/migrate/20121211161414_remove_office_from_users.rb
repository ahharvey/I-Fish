class RemoveOfficeFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :office_id
  end
end
