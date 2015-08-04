class AddBaitToBaitLoading < ActiveRecord::Migration
  def change
    add_reference :bait_loadings, :bait, index: true, foreign_key: true
    add_reference :bait_loadings, :secondary_bait, references: :fishes, index: true
    add_foreign_key :bait_loadings, :baits, column: :secondary_bait_id
  end
end
