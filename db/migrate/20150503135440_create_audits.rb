class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.references :admin, index: true, foreign_key: true
      t.references :auditable, polymorphic: true, index: true
      t.text :comment
      t.string :status

      t.timestamps null: false
    end
  end
end
