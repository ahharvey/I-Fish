class AddUniquenessIndextoRoleJoinTables < ActiveRecord::Migration
  
  def change
  	add_index :admins_roles, [ :admin_id, :role_id ], :unique => true, :name => 'by_admin_and_role'
  	add_index :roles_users, [ :user_id, :role_id ], :unique => true, :name => 'by_user_and_role'
  end

end
