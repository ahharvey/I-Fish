class AddLocationFieldsToDesa < ActiveRecord::Migration
  def change
  	add_column :desas, :lat, :float
  	add_column :desas, :lng, :float
  end
end
