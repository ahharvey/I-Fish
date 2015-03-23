class AddBycatchToUnloadings < ActiveRecord::Migration
  def change
    add_column :unloadings, :byproduct, :integer
    add_column :unloadings, :discard, :integer
    add_column :unloadings, :yft, :integer
    add_column :unloadings, :bet, :integer
    add_column :unloadings, :skj, :integer
    add_column :unloadings, :kaw, :integer
  end
end
