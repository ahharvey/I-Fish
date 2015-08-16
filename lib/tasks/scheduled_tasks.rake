namespace :scheduled_tasks do
  desc "processings..........."
  
  task :cleanup_processed_importers => :environment do
    completed = Importer.where( review_state: 'approved').where( 'reviewed_at < ?', Date.today.beginning_of_week-1.week )
    failed    = Importer.where( review_state: 'rejected').where( 'reviewed_at < ?', Date.today.beginning_of_week-1.week )
    completed.each do |i|
      i.destroy
    end
    failed.each do |i|
      i.destroy
    end
  end
end