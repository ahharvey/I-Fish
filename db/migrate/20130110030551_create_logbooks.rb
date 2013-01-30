class CreateLogbooks < ActiveRecord::Migration
  def change
    create_table :logbooks do |t|
      t.date :date
      t.references :admin
      t.references :user

      t.timestamps
    end
    add_index :logbooks, :admin_id
    add_index :logbooks, :user_id
  end
end
