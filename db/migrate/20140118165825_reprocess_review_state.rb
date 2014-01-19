class ReprocessReviewState < ActiveRecord::Migration
  def up
    Survey.where("reviewer_id IS NOT NULL").each do |s|
      s.review_state='approved'
      s.reviewed_at=DateTime.now
      s.save
    end

    Logbook.where("reviewer_id IS NOT NULL").each do |l|
      l.review_state='approved'
      l.reviewed_at=DateTime.now
      l.save
    end
  end

end
