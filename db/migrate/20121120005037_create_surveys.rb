class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.date :date
      t.integer :user_id
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :desa_id
      t.string :observer
      t.string :measure
      t.string :scribe
      t.string :fishery

      t.timestamps
    end
  end
end
