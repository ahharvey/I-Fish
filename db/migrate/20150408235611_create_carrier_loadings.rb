class CreateCarrierLoadings < ActiveRecord::Migration
  def change
    create_table :carrier_loadings do |t|
      t.date :date
      t.references :vessel, index: true, foreign_key: true
      t.references :fish, index: true
      t.string :location
      t.string :size
      t.string :grade
      t.integer :quantity
      t.string :review_state, :string, default: 'pending'

      #add_foreign_key :carrier_loadings, :fish
    end
  end


end
