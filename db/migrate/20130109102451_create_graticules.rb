class CreateGraticules < ActiveRecord::Migration
  def change
    create_table :graticules do |t|
      t.string :code

      t.timestamps
    end
  end
end
