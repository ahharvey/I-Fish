class AddVariousNewFields < ActiveRecord::Migration
  def change
  	add_column :districts, :code, :integer
  	add_column :landings, :cpue_kg, :integer
  	add_column :landings, :cpue_idr, :integer
  	add_column :landings, :cpue_fuel, :integer
  end
end
