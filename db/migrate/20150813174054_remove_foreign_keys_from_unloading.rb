class RemoveForeignKeysFromUnloading < ActiveRecord::Migration
  def change
  	remove_foreign_key :unloadings, :port
  	remove_foreign_key :unloadings, :wpp
  	
  	remove_foreign_key :unloadings, :user
  	remove_foreign_key :unloadings, :admin
  	remove_foreign_key :unloadings, :grid
  	remove_foreign_key :unloading_catches, :size_class
  end
end
