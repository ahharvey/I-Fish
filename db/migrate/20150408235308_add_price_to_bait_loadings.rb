class AddPriceToBaitLoadings < ActiveRecord::Migration
  def change
    add_column :bait_loadings, :price, :integer
    add_column :bait_loadings, :method_type, :string
    add_column :bait_loadings, :review_state, :string, default: 'pending'
  end
end
