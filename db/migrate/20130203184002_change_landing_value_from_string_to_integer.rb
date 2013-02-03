class ChangeLandingValueFromStringToInteger < ActiveRecord::Migration
  
  def self.up
   remove_column :landings, :value
   add_column :landings, :value, :integer
  end

  def self.down
   remove_column :landings, :value
   add_column :landings, :value, :string
  end
end
