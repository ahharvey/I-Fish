class AddStatusToImporter < ActiveRecord::Migration
  def change
    add_column :importers, :review_state, :string
    add_column :importers, :reviewed_at, :datetime
  end
end
