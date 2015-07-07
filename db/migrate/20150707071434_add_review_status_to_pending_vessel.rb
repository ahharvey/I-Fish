class AddReviewStatusToPendingVessel < ActiveRecord::Migration
  def change

    add_column :pending_vessels, :review_state, :string, default: 'pending'
    add_column :pending_vessels, :reviewed_at, :datetime
  end
end
