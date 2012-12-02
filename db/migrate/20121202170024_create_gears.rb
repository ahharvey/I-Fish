class CreateGears < ActiveRecord::Migration
  def change
    create_table :gears do |t|
      t.string :cat_ind
      t.string :cat_eng
      t.string :sub_cat_ind
      t.string :sub_cat_eng
      t.string :type_ind
      t.string :type_eng
      t.string :name
      t.string :alpha_code
      t.string :num_code
      t.string :fao_code

      t.timestamps
    end
  end
end
