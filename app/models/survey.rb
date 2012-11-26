class Survey < ActiveRecord::Base
  attr_accessible :date, :desa_id, :end_time, :fishery, :fishery_id, :measure, 
    :fleet_observer, :catch_scribe, :start_time, :user_id
  
  belongs_to :user
  belongs_to :fishery
  belongs_to :desa
end
