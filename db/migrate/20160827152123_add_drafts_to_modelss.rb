class AddDraftsToModelss < ActiveRecord::Migration
  def change
    add_column :fisheries, :draft_id, :integer
    add_column :fisheries, :published_at, :timestamp
    add_column :fisheries, :trashed_at, :timestamp

    add_column :fishes, :draft_id, :integer
    add_column :fishes, :published_at, :timestamp
    add_column :fishes, :trashed_at, :timestamp

    add_column :vessels, :draft_id, :integer
    add_column :vessels, :published_at, :timestamp
    add_column :vessels, :trashed_at, :timestamp

    add_column :companies, :draft_id, :integer
    add_column :companies, :published_at, :timestamp
    add_column :companies, :trashed_at, :timestamp

  end
end
