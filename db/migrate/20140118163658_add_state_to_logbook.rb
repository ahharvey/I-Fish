class AddStateToLogbook < ActiveRecord::Migration
  def up
    add_column :logbooks, :review_state, :string, state: 'pending'
    add_column :logbooks, :reviewed_at, :datetime

    Logbook.where(approved: true).each do |l|
      l.review_state = "approved"
      l.reviewed_at = DateTime.now
      l.save 
    end
    
    rename_column :logbooks, :approver_id, :reviewer_id
    remove_column :logbooks, :approved
  end

  def down
    add_column :logbooks, :approved, :boolean

    Logbook.where(review_state: 'approved').each do |l|
      l.approved = true
      l.save 
    end
    
    rename_column :logbooks, :reviewer_id, :approver_id
    
    remove_column :logbooks, :review_state, :string
    remove_column :logbooks, :reviewed_at, :datetime
  end
end
