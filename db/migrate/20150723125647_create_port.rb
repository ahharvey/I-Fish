class CreatePort < ActiveRecord::Migration
  def change
    create_table :ports do |t|
      t.string :name
    end
  end
end
