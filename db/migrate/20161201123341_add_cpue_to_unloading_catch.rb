class AddCpueToUnloadingCatch < ActiveRecord::Migration[5.0]
  def change
    add_column :unloading_catches, :cpue, :integer, default: 0
  end
end
