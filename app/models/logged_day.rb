# == Schema Information
#
# Table name: logged_days
#
#  id           :integer          not null, primary key
#  start_time   :datetime
#  end_time     :datetime
#  gear_time    :integer
#  fuel         :integer
#  sail         :boolean
#  net          :boolean
#  line         :boolean
#  quantity     :integer
#  weight       :integer
#  value        :integer
#  condition    :integer
#  moon         :integer
#  fish_id      :integer
#  graticule_id :integer
#  logbook_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  crew         :integer
#

class LoggedDay < ActiveRecord::Base
  
  has_paper_trail

  belongs_to :fish
  belongs_to :graticule
  belongs_to :logbook
  has_one :fishery, through: :logbook
  attr_accessible :condition,
                  :crew,
                  :end_time,
                  :fuel,
                  :gear_time,
                  :line,
                  :moon,
                  :net,
                  :quantity,
                  :sail,
                  :start_time,
                  :value,
                  :weight,
                  :fish_id,
                  :logbook_id,
                  :graticule_id,
                  :ice,
                  :aborted,
                  :notes

  validates :condition,
    presence: {
      message: " is not defined." 
    },
    inclusion: { 
      in: 1..3,
      message: " is not recognized." 
    },
    unless: [ :aborted?, :inactive? ]
  
  validates :start_time,
    presence: {
      message: " is not defined." 
    }
  validates :end_time,
    presence: {
      message: " is not defined." 
    }
  validates :gear_time,
    presence: {
      message: " is not defined." 
    }

#  validates :line,
#    inclusion: {
#      in: [true, false],
#      message: " is not defined." 
#    },
#    if: Proc.new { |l| l.fishery.code == 'LOM-PS' }
#  validates :net,
#    inclusion: {
#      in: [true, false],
#      message: " is not defined." 
#    }
#    #,
#    #if: Proc.new { |l| l.fishery.code == 'LOM-PS' }
#  validates :sail,
#    inclusion: {
#      in: [true, false],
#      message: " is not defined." 
#    }
#    #,
#    #if: Proc.new { |l| l.fishery.code == 'LOM-PS' }
  validates :aborted,
    inclusion: {
      in: [true, false],
      message: " is not defined." 
    },
    unless: [ :inactive? ]

  validates :crew,
    presence: {
      message: " is not defined." 
    },
    numericality: {
      message: " is not a number."
    }
  validates :fuel,
    presence: {
      message: " is not defined." 
    },
    numericality: {
      message: " is not a number."
    }
  validates :quantity,
    presence: {
      message: " is not defined." 
    },
    numericality: {
      message: " is not a number."
    }
  validates :value,
    presence: {
      message: " is not defined." 
    },
    numericality: {
      message: " is not a number."
    }
#  validates :weight,
#    presence: {
#      message: " is not defined." 
#    },
#    numericality: {
#      message: " is not a number."
#    }
  validates :ice,
    presence: {
      message: " is not defined." 
    },
    numericality: {
      message: " is not a number."
    }

  validates :fish,
    presence: {
      message: " is not recognized." 
    },
    unless: [ :aborted?, :inactive? ]
  validates :graticule,
    presence: {
      message: " is not recognized." 
    },
    unless: [ :aborted?, :inactive? ]


  @@condition_data = { 1 => "Calm" , 2 => "Moderate" , 3 => "High" }
  @@moon_data = { 1 => "New" , 2 => "Waxing" , 3 => "Full" , 4 => "Waning"  }

  def condition_as_text
    @@condition_data[condition]
  end

  def moon_as_text
    @@moon_data[moon]
  end

  #private

  def inactive?
    start_time == end_time
    #true
  end


end
