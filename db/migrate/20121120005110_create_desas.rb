class CreateDesas < ActiveRecord::Migration
  def change
    create_table :desas do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
