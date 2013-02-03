class AddDistrictToOffice < ActiveRecord::Migration
  def change
    add_column :offices, :district_id, :integer
  end
end
