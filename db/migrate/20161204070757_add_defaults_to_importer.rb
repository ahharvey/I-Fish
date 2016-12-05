class AddDefaultsToImporter < ActiveRecord::Migration[5.0]
  def up
    change_column :importers, :review_state, :string,   default: 'pending'
    change_column :importers, :reviewed_at,  :datetime, default: -> { 'NOW()' }
  end
  def down
    change_column :importers, :review_state, :string,   default: nil
    change_column :importers, :reviewed_at,  :datetime, default: nil
  end
end
