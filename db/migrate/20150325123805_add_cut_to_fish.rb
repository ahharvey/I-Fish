class AddCutToFish < ActiveRecord::Migration
  def change
    add_column :unloading_catches, :cut_type, :string
  end
end
