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
  
  attr_writer :start_time_input, :end_time_input, :date_input

  before_save :save_start_at, :save_end_at  
  validate :check_start_at, :check_end_at


  validates :condition,
    presence: {
      message: " is not defined." 
    },
    inclusion: { 
      in: 1..3,
      message: " is not recognized." 
    },
    unless: [ :aborted?, :inactive? ]
  
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
    unless: [ :aborted?, :inactive?, :nofish? ]
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

  # handles setting of start time
  def start_time_input
    @start_time_input || start_time.try(:strftime, "%H:%M")
  end

  # handles setting of end time
  def end_time_input
    @end_time_input || end_time.try(:strftime, "%H:%M")
  end

  # handles entry of date
  def date_input
    @date_input || start_time.try(:strftime, "%Y-%m-%d")
  end
  
  # combines time and date to set value of start_time 
  def save_start_at
    self.start_time = Time.zone.parse("#{@date_input} #{@start_time_input}" ) if ( @start_time_input.present? && @date_input.present? )
  end

  # combines time and date to set value of end_time 
  def save_end_at
    self.end_time = Time.zone.parse("#{@date_input} #{@end_time_input}" ) if ( @end_time_input.present? && @date_input.present? )
  end
  
  # validates start time
  def check_start_at
    if  ( @start_time_input.present? && @date_input.present? ) && Time.zone.parse( "#{@date_input} #{@start_time_input}" ).nil?
      errors.add :start_time, "cannot be parsed"
    elsif @start_time_input.present? && !@date_input.present?
      errors.add :start_date_input, "cannot be blank"
    elsif !@start_time_input.present? && @date_input.present?
      errors.add :start_time_input, "cannot be blank"
    end
  rescue ArgumentError
    errors.add :start_date_input, "is not defined"   
  end

  # validates end time
  def check_end_at
    if  ( @end_time_input.present? && @date_input.present? ) && Time.zone.parse( "#{@date_input} #{@end_time_input}" ).nil?
      errors.add :end_time, "cannot be parsed"
    elsif @end_time_input.present? && !@date_input.present?
      errors.add :end_date_input, "cannot be blank"
    elsif !@end_time_input.present? && @date_input.present?
      errors.add :end_time_input, "cannot be blank"
    end
  rescue ArgumentError
    errors.add :end_date_input, "is not defined"   
  end

  #private

  def inactive?
    start_time == end_time
    #true
  end

  def nofish?
    quantity == 0 && weight == 0
  end

  def logged_date
    start_time.to_date.strftime("%d")
  end

  def formatted_graticule
    graticule.code
  end

  def formatted_sail
    sail.yn
  end

  def formatted_fish
    fish.code
  end

  def formatted_date
    start_time.try(:strftime, "%d")
  end

end
