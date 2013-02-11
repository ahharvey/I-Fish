class ChangeColumnTypes < ActiveRecord::Migration
  def up
  	remove_column :landings, :sail
  	remove_column :landings, :fuel
  	remove_column :landings, :power
  	remove_column :landings, :crew
   	
   	add_column :landings, :sail, :boolean
   	add_column :landings, :fuel, :integer
   	add_column :landings, :power, :integer
   	add_column :landings, :crew, :integer
  end

  def down
  	remove_column :landings, :sail
  	remove_column :landings, :fuel
  	remove_column :landings, :power
  	remove_column :landings, :crew
   	
   	add_column :landings, :sail, :string
   	add_column :landings, :fuel, :string
   	add_column :landings, :power, :string
   	add_column :landings, :crew, :string
  end
end
