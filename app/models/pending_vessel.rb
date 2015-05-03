class PendingVessel <  ActiveRecord::Base
	acts_as_vessel
  belongs_to :vessel
end