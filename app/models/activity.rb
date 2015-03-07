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
  #default_scope order('created_at DESC')
  # default_scope where(color: 'red')
# default_scope { where(color: 'red') }
# scope :published, -> { where('published_on <= ?', Time.now.to_date) }
 # default_scope { order(:created_at DESC) }
  default_scope { order('created_at DESC') }
  belongs_to :ownable, polymorphic: true
  belongs_to :trackable, polymorphic: true
  
end
