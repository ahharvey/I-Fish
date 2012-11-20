class CreateFish < ActiveRecord::Migration
  def change
    create_table :fish do |t|
      t.string :family
      t.string :genus
      t.string :species
      t.string :english_name
      t.string :local_name
      t.string :code

      t.timestamps
    end
  end
end
