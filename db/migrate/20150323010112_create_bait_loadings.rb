class CreateBaitLoadings < ActiveRecord::Migration
  def change
    create_table :bait_loadings do |t|
      t.date :date
      t.references :vessel, index: true
      t.string :location
      t.references :fish, index: true
      t.integer :quantity
      t.references :unloading, index: true

      t.timestamps null: false
    end
    add_foreign_key :bait_loadings, :vessels
    add_foreign_key :bait_loadings, :fishes
    add_foreign_key :bait_loadings, :unloadings
  end
end
