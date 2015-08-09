class AddCpueToUnloading < ActiveRecord::Migration
  def change
    add_column :unloadings, :cpue, :decimal
  end
end
