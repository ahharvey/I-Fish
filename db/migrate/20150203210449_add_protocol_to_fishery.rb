class AddProtocolToFishery < ActiveRecord::Migration
  def change
    add_column :fisheries, :protocol_id, :integer
  end
end
