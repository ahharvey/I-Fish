module HasBaitRatio
  extend ActiveSupport::Concern

  def to_bait_ratio current=false
    if current
      catches = self.unloading_catches.current.group_by_month_of_year('unloadings.time_in', format: '%b').sum(:quantity)
      baits   = self.bait_loadings.current.group_by_month_of_year(:date, format: '%b').sum(:quantity)
    else
      catches = self.unloading_catches.group_by_month_of_year('unloadings.time_in', format: '%b').sum(:quantity)
      baits   = self.bait_loadings.group_by_month_of_year(:date, format: '%b').sum(:quantity)
    end
    h = Hash.new
    catches.each do |k,v|
      adj = 0   if  v == 0
      adj = (100 * baits[k].to_f)/ v.to_f  unless   v == 0

      h[k] = adj
    end
    h
  end
end
