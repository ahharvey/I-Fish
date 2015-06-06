class AddGridToUnloading < ActiveRecord::Migration
  def change
    add_reference :unloadings, :grid, index: true, foreign_key: true
  end
end
