class ActiveRecord::Base
  def self.acts_as_reviewable
    include ReviewableMixin
  end
end