class CreateSizeClass < ActiveRecord::Migration
  def change
    create_table :size_classes do |t|
      t.decimal :upper
      t.decimal :lower
      t.decimal :median
      t.string :name
    end
  end
end
