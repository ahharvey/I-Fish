class AddParentToImporters < ActiveRecord::Migration[5.0]
  def change
    add_reference :importers, :parent, polymorphic: true
    add_reference :importers, :imported_by, polymorphic: true
  end
end
