class PendingVessel <  ActiveRecord::Base
	acts_as_vessel
  belongs_to :vessel

  scope :default, -> { order('pending_vessels.created_at DESC') }
end