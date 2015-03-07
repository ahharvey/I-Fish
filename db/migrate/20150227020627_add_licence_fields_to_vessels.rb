class AddLicenceFieldsToVessels < ActiveRecord::Migration
  def change
    add_column :vessels, :crew, :integer
    add_column :vessels, :hooks, :integer
    add_column :vessels, :captain, :string
    add_column :vessels, :owner, :string
    add_column :vessels, :sipi_number, :string
    add_column :vessels, :sipi_expiry, :date
    add_column :vessels, :siup_number, :string

    add_column :vessels, :issf_ref_requested, :boolean
  end
end
