class CreateBait < ActiveRecord::Migration
  def change
    create_table :baits do |t|
      t.string :name
      t.string :code
    end
  end
end
