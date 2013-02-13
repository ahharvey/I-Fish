class AddFishbaseDataToFish < ActiveRecord::Migration
  def change
  	add_column :fishes, :a, :integer
  	add_column :fishes, :b, :integer
  	add_column :fishes, :mat, :integer
  	add_column :fishes, :max, :integer
  	add_column :fishes, :opt, :integer
  	add_column :fishes, :threatened, :boolean, default: false
  end
end
