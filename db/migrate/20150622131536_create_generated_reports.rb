class CreateGeneratedReports < ActiveRecord::Migration
  def change
    create_table :generated_reports do |t|
      t.string :file

      t.timestamps null: false
    end
  end
end
