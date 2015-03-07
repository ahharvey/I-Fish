class CreateVessels < ActiveRecord::Migration
  def change
    create_table :vessels do |t|
      t.string :name
      t.references :vessel_type, index: true
      t.references :gear, index: true
      t.string :flag_state
      t.string :year_built
      t.integer :length
      t.integer :tonnage
      t.string :imo_number
      t.boolean :shark_policy
      t.boolean :iuu_list
      t.boolean :code_of_conduct
      t.references :company, index: true
      t.string :ap2hi_ref
      t.string :issf_ref

      t.timestamps null: false
    end
    add_foreign_key :vessels, :vessel_types
    add_foreign_key :vessels, :gears
    add_foreign_key :vessels, :companies
  end
end
