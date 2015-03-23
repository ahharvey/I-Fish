class AddUnloadingReferenceToUnloadingCatch < ActiveRecord::Migration
  def change
    add_reference :unloading_catches, :unloading, index: true
    #add_foreign_key :unloading_catches, :unloadings
  end
end
