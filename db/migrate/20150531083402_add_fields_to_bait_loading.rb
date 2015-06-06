class AddFieldsToBaitLoading < ActiveRecord::Migration
  def change
    add_reference :bait_loadings, :grid, index: true, foreign_key: true
    add_reference :bait_loadings, :secondary_fish, references: :fishes, index: true
    add_foreign_key :bait_loadings, :fishes, column: :secondary_fish_id
  end
end
