class RenamePortOnUnloading < ActiveRecord::Migration[5.0]
  def change
    rename_column :unloadings, :port, :old_port
  end
end
