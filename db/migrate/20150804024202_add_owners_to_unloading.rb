class AddOwnersToUnloading < ActiveRecord::Migration
  def change
    add_reference :unloadings, :user, index: true, foreign_key: true
    add_reference :unloadings, :admin, index: true, foreign_key: true
  end
end
