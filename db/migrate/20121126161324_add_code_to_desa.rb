class AddCodeToDesa < ActiveRecord::Migration
  def change
    add_column :desas, :code, :string
    remove_column :desas, :kabupaten
  end
end
