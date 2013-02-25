class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :action
      t.belongs_to :ownable
      t.string :ownable_type
      t.belongs_to :trackable
      t.string :trackable_type

      t.timestamps
    end
    add_index :activities, :ownable_id
    add_index :activities, :trackable_id
  end
end
