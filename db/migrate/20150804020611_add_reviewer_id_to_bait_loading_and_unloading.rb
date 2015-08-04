class AddReviewerIdToBaitLoadingAndUnloading < ActiveRecord::Migration
  def change
  	add_column :bait_loadings, :reviewer_id, :integer
  	add_index  :bait_loadings, :reviewer_id
  	add_column :bait_loadings, :reviewed_at, :datetime

  	add_column :unloadings, :reviewer_id, :integer
  	add_index  :unloadings, :reviewer_id
  	add_column :unloadings, :reviewed_at, :datetime
  end
end
