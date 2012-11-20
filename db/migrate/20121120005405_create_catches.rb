class CreateCatches < ActiveRecord::Migration
  def change
    create_table :catches do |t|
      t.integer :fish_id
      t.integer :length
      t.integer :weight

      t.timestamps
    end
  end
end
