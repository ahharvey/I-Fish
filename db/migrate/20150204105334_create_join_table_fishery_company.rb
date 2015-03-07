class CreateJoinTableFisheryCompany < ActiveRecord::Migration
  def up
    create_table :fisheries_companies, :id => false do |t|
      t.references :fishery, :company
    end
  end

  def down
    drop_table :fisheries_companies
  end
end
