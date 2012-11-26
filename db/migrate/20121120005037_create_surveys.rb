class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.date :date
      t.integer :user_id
      t.integer :desa_id
      t.string :fishery
      t.string :observer
      t.string :measure
      t.string :scribe
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
