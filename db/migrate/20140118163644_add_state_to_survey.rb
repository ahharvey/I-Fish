class AddStateToSurvey < ActiveRecord::Migration
  def up
    add_column :surveys, :review_state, :string, default: 'pending'
    add_column :surveys, :reviewed_at, :datetime

    Survey.where(approved: true).each do |s|
      s.review_state = "approved"
      s.reviewed_at = DateTime.now
      s.save 
    end
    
    rename_column :surveys, :approver_id, :reviewer_id
    remove_column :surveys, :approved
  end

  def down
    add_column :surveys, :approved, :boolean

    Survey.where(review_state: 'approved').each do |s|
      s.approved = true
      s.save 
    end
    
    rename_column :surveys, :reviewer_id, :approver_id
    
    remove_column :surveys, :review_state, :string
    remove_column :surveys, :reviewed_at, :datetime
  end
end
