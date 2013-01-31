class CreateVesselTypes < ActiveRecord::Migration
  def change
    create_table :vessel_types do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
