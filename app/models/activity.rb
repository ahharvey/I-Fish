class Activity < ActiveRecord::Base
  default_scope order('created_at DESC')
  belongs_to :ownable, polymorphic: true
  belongs_to :trackable, polymorphic: true
  attr_accessible :action, :ownable, :trackable
end
