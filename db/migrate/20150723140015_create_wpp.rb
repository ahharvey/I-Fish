class CreateWpp < ActiveRecord::Migration
  def change
    create_table :wpps do |t|
      t.string :name
    end
  end
end
