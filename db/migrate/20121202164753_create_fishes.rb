class CreateFishes < ActiveRecord::Migration
  def change
    create_table :fishes do |t|
      t.string :order
      t.string :family
      t.string :scientific_name
      t.string :fishbase_name
      t.string :english_name
      t.string :indonesia_name
      t.string :code

      t.timestamps
    end
  end
end
