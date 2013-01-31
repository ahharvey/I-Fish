class CreateLoggedDays < ActiveRecord::Migration
  def change
    create_table :logged_days do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :gear_time
      t.integer :fuel
      t.boolean :sail
      t.boolean :net
      t.boolean :line
      t.integer :quantity
      t.integer :weight
      t.integer :value
      t.integer :condition
      t.integer :moon
      t.references :fish
      t.references :graticule
      t.references :logbook

      t.timestamps
    end
    add_index :logged_days, :fish_id
    add_index :logged_days, :graticule_id
    add_index :logged_days, :logbook_id
  end
end
