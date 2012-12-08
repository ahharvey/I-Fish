class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.string :power
      t.string :fishing_area
      t.string :vessel_ref
      t.string :vessel_name
      t.string :grid_square
      t.string :engine
      t.string :fuel
      t.string :sail
      t.string :crew
      t.string :value
      t.integer :boat_size
      t.integer :gear_id
      t.integer :survey_id
      t.integer :quantity
      t.integer :weight
      t.timestamp :time_out
      t.timestamp :time_in

      t.timestamps
    end
  end
end
