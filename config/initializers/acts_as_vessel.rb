class ActiveRecord::Base
  def self.acts_as_vessel
    include BaseVessel
  end
end