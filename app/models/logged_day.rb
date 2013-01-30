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
