class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.string :vessel_ref
      t.string :vessel_name
      t.string :grid_square
      t.timestamp :time_out
      t.timestamp :time_in
      t.string :engine
      t.string :fuel
      t.string :sail
      t.string :crew
      t.integer :boat_size
      t.integer :gear_id
      t.integer :quantity
      t.integer :weight
      t.string :value

      t.timestamps
    end
  end
end
