class AddCodesToGraticuleAndEngineAndVesselType < ActiveRecord::Migration
  def change
  	add_column :engines, :code, :integer
  	add_column :vessel_types, :code, :integer
  end
end
