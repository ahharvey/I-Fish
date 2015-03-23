class CreateUnloadings < ActiveRecord::Migration
  def change
    create_table :unloadings do |t|
      t.string :port
      t.datetime :time_out
      t.datetime :time_in
      t.boolean :etp
      t.string :location
      t.integer :fuel
      t.integer :ice

      t.timestamps null: false
    end
  end
end
