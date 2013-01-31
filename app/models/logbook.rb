class Logbook < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  belongs_to :fishery
  has_many :logged_days
  attr_accessible :date, :user_id, :admin_id, :fishery_id

  validates_uniqueness_of :date, :scope => :fishery_id
end
