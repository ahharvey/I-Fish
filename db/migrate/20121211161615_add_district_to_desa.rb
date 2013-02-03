class AddDistrictToDesa < ActiveRecord::Migration
  def change
    add_column :desas, :district_id, :integer
  end
end
