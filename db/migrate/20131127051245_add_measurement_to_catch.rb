class AddMeasurementToCatch < ActiveRecord::Migration
  def change
    add_column :catches, :measurement, :string
  end
end
