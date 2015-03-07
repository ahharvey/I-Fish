class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.boolean :shark_policy
      t.boolean :iuu_list
      t.boolean :code_of_conduct
      t.boolean :member
      t.string :avatar

      t.timestamps null: false
    end
  end
end
