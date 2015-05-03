class CreatePendingVessels < ActiveRecord::Migration
  def change
    create_table :pending_vessels do |t|
      t.string :name
      t.references :vessel_type, index: true, foreign_key: true
      t.references :gear, index: true, foreign_key: true
      t.string :flag_state
      t.string :year_built
      t.integer :length
      t.integer :tonnage
      t.references :company, index: true, foreign_key: true
      t.integer :crew
      t.integer :hooks
      t.string :captain
      t.string :owner
      t.string :sipi_number
      t.date :sipi_expiry
      t.string :siup_number
      t.string :material_type
      t.string :machine_type
      t.integer :capacity
      t.boolean :vms
      t.boolean :tracker
      t.string :port
      t.boolean :name_changed
      t.boolean :flag_state_changed
      t.string :radio
      t.string :relationship_type
      t.integer :fish_capacity
      t.integer :bait_capacity
      t.string :location_built
      t.string :status
      t.references :admin, index: true, foreign_key: true
      t.references :vessel, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
