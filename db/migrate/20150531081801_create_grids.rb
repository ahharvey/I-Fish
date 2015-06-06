class CreateGrids < ActiveRecord::Migration
  def change
    create_table :grids do |t|
      t.integer :xaxis
      t.string :yaxis, limit: 1

      t.timestamps null: false
    end
  end
end
