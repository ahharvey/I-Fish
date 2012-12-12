class AddOfficeToAdmins < ActiveRecord::Migration
  def change
  	add_column :admins, :office_id, :integer
  end
end
