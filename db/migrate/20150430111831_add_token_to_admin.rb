class AddTokenToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :access_token, :string, unique: true
  end
end
