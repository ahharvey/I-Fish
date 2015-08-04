class CreateCompanyPositions < ActiveRecord::Migration
  def change
    create_table :company_positions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.string :status
    end
  end
end
