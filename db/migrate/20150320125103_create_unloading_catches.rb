class CreateUnloadingCatches < ActiveRecord::Migration
  def change
    create_table :unloading_catches do |t|
      t.references :fish, index: true
      t.integer :quantity

      t.timestamps null: false
    end
    add_foreign_key :unloading_catches, :fishes
  end
end
