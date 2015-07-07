class AddAuditIdToPendingVessel < ActiveRecord::Migration
  def change
    add_reference :pending_vessels, :audit, index: true, foreign_key: true
  end
end
