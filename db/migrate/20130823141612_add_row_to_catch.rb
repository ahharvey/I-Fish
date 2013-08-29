class AddRowToCatch < ActiveRecord::Migration
  def change
    add_column :catches, :row, :integer
  end
end
