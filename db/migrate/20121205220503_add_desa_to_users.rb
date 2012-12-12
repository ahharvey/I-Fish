class AddDesaToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :desa_id, :integer
  end
end
