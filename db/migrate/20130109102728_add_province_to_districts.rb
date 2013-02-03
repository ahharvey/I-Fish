class AddProvinceToDistricts < ActiveRecord::Migration
  def change
  	add_column :districts, :province_id, :integer
  end
end
