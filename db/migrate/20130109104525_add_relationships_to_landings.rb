class AddRelationshipsToLandings < ActiveRecord::Migration
  def change
  	add_column :landings, :engine_id, :integer
  	add_column :landings, :graticule_id, :integer
  	remove_column :landings, :fishing_area
  	remove_column :landings, :engine
  	remove_column :landings, :grid_square

  end
end
