class AddUniqueIndexToRoles < ActiveRecord::Migration
  def change
  	add_index :roles, [ :name ], :unique => true, :name => 'index_roles_on_name'
  end
end
