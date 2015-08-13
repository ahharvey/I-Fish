class CreateImporter < ActiveRecord::Migration
  def change
    create_table :importers do |t|
      t.text :file
      t.string :label
    end
  end
end
