class AddRowAndSamplingFactorToLandingAndCatch < ActiveRecord::Migration
  def change
    add_column :landings, :row, :integer
    add_column :catches, :sfactor, :string
    remove_column :catches, :weight
  end
end
