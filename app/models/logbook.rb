# == Schema Information
#
# Table name: logbooks
#
#  id          :integer          not null, primary key
#  date        :date
#  admin_id    :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  fishery_id  :integer
#  approver_id :integer
#  approved    :boolean          default(FALSE), not null
#

class Logbook < ActiveRecord::Base
  
  has_paper_trail

  belongs_to :user
  belongs_to :admin
  belongs_to :approver, :class_name => 'Admin'
  belongs_to :fishery
  has_many :logged_days
  attr_accessible :date, :user_id, :admin_id, :fishery_id, :approved

  #validates_uniqueness_of :date, :scope => :user_id

  def surveys_this_month
    prereps.where( 'prereps.created_at > ?', Date.today.beginning_of_month ).size
  end

  def logbooks_this_month
    logbooks.where( 'prereps.created_at > ?', Date.today.beginning_of_month ).size
  end

  def self.completed_this_month
    Logbook.where( date: Date.today.beginning_of_month..Date.today.end_of_month ).size
  end

  def self.completed_last_month
    Logbook.where( date: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month ).size
  end
end
