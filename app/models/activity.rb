# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  action         :string(255)
#  ownable_id     :integer
#  ownable_type   :string(255)
#  trackable_id   :integer
#  trackable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Activity < ActiveRecord::Base
  default_scope order('created_at DESC')
  belongs_to :ownable, polymorphic: true
  belongs_to :trackable, polymorphic: true
  attr_accessible :action, :ownable, :trackable, :trackable_type, :trackable_id, :ownable_id, :ownable_type
end
