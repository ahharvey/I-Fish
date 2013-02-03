class AddEffortToLandings < ActiveRecord::Migration
  def change
  	add_column :landings, :cpue, :integer
  end
end
