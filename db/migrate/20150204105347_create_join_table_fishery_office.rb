class CreateJoinTableFisheryOffice < ActiveRecord::Migration
  def up
    create_table :fisheries_offices, :id => false do |t|
      t.references :fishery, :office
    end
  end

  def down
    drop_table :fisheries_offices
  end
end
