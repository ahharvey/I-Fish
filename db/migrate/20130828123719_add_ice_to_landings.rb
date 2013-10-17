class AddIceToLandings < ActiveRecord::Migration
  def change
    add_column :landings, :ice, :integer
    add_column :landings, :conditions, :integer
    add_column :landings, :aborted, :boolean
    add_column :logged_days, :aborted, :boolean
    add_column :logged_days, :ice, :integer
  end
end
