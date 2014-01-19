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
  belongs_to :reviewer, :class_name => 'Admin'
  belongs_to :fishery
  has_many :logged_days
  attr_accessible :date, :user_id, :admin_id, :fishery_id, :review_state, :reviewed_at, :reviewer_id

  validates :date, 
    presence: {
      message: " is not defined."
    },
    uniqueness: { 
      scope: [ :user_id, :fishery_id ] 
    }
  validates :fishery,
    presence: {
      message: " is not recognized." 
    }
  validates :user,
    presence: {
      message: " is not recognized." 
    }
  validates :admin,
    presence: {
      message: " is not recognized." 
    }

  STATES = %w{ pending rejected approved }

  STATES.each do |state|
    define_method("#{state}?") do
      self.review_state == state
    end

    define_method("#{state}!") do
      self.update_attributes(
        review_state: state,
        reviewed_at: DateTime.now
        )
    end
  end

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

  def self.approved_this_month
    Logbook.where( date: Date.today.beginning_of_month..Date.today.end_of_month, review_state: 'approved' ).size
  end

  def self.approved_last_month
    Logbook.where( date: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month, review_state: 'approved' ).size
  end
end
