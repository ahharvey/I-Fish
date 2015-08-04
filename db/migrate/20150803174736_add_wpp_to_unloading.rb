class AddWppToUnloading < ActiveRecord::Migration
  def change
    add_reference :unloadings, :wpp, index: true, foreign_key: true
  end
end
