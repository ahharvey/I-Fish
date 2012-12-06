class Survey < ActiveRecord::Base
  attr_accessible :date, :desa_id, :end_time, :fishery, :measure, :observer, :scribe, :start_time, :user_id

  belongs_to :user
  belongs_to :desa
end
