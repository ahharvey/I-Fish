class AddReviewStateToUnloading < ActiveRecord::Migration
  def change
    add_reference :unloadings, :vessel, index: true
    add_column :unloadings, :review_state, :string, default: 'pending'
  end
end
