class Survey < ActiveRecord::Base
  attr_accessible :date, :desa_id, :end_time, :fishery_id, :catch_measure,
    :fleet_observer, :catch_scribe, :start_time, :user_id, :date_published
  
  belongs_to :user
  belongs_to :fishery
  belongs_to :desa
  has_many :landings

  def self.import_from_email(params)
  	puts "begin import surveys from email:"
  	puts params
  	puts "-----------------------------------"
  end
end
