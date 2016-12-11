class AddBooleansToUnloading < ActiveRecord::Migration[5.0]
  def change
    add_column :unloadings, :port_sampling, :boolean, default: false
    add_column :unloadings, :vms,           :boolean, default: false
    add_column :unloadings, :observer,      :boolean, default: false
  end
end
