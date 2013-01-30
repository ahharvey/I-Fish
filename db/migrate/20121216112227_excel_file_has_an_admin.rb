class ExcelFileHasAnAdmin < ActiveRecord::Migration
  def change
  	remove_column :excel_files, :user_id
  	add_column :excel_files, :admin_id, :integer
  end
end
