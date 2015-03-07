class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.string :file
      t.string :content_type
      t.string :file_size
      t.integer :documentable_id
      t.string :documentable_type
      t.timestamps null: false
    end
  end
end
