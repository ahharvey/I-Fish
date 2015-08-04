class AddTypeToUnloading < ActiveRecord::Migration
  def change
    add_column :unloading_catches, :type, :string
  end
end
