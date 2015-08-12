class ChangeCatchColumnForUnloadingCatches < ActiveRecord::Migration
  def change
  	rename_column :unloading_catches, :type, :catch_type
  end
end
