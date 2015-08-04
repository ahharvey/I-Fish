class AddPortToUnloading < ActiveRecord::Migration
  def change
    add_reference :unloadings, :port, index: true, foreign_key: true
  end
end
