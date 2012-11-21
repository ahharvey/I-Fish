class CreateExcelFiles < ActiveRecord::Migration
  def change
    create_table :excel_files do |t|
      t.string :filename
      t.string :filesize
      t.string :file

      t.timestamps
    end
  end
end
