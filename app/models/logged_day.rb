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
  belongs_to :fish
  belongs_to :graticule
  belongs_to :logbook
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
                  :graticule_id

  @@condition_data = { 1 => "Calm" , 2 => "Moderate" , 3 => "High" }
  @@moon_data = { 1 => "New" , 2 => "Waxing" , 3 => "Full" , 4 => "Waning"  }

  def condition_as_text
    @@condition_data[condition]
  end

  def moon_as_text
    @@moon_data[moon]
  end
end
