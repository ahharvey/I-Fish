class ChangedFieldTypeOfDateField < ActiveRecord::Migration
  def up
    change_column :surveys, :date, :string
  end

  def down
  end
end
