class AddCatchCertificateToUnloadings < ActiveRecord::Migration
  def change
    add_column :unloadings, :catch_certificate, :string
    add_column :unloadings, :budget, :integer
  end
end
