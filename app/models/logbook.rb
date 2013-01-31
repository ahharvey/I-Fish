# == Schema Information
#
# Table name: logbooks
#
#  id         :integer          not null, primary key
#  date       :date
#  admin_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fishery_id :integer
#

class Logbook < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :admin
  belongs_to :fishery
  has_many :logged_days
  attr_accessible :date, :user_id, :admin_id, :fishery_id

  
end
