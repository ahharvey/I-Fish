class LoggedDayPresenter < BasePresenter
  presents :logged_day

  def start_date
#    handle_none logged_day.start_time do
#      logged_day.start_time.to_date.strftime("%d") 
#    end
    best_in_place logged_day, :date_input, type: :input, nil: '--', inner_class: 'span1', display_as: :formatted_date
  end

  def start_time
#    handle_none logged_day.start_time do
#      logged_day.start_time.to_s(:time)
#    end
    best_in_place logged_day, :start_time_input, type: :input, nil: '--', inner_class: 'span1'
  end

  def end_time
#    handle_none logged_day.end_time do
#      logged_day.end_time.to_s(:time)
#    end
    best_in_place logged_day, :end_time_input, type: :input, nil: '--', inner_class: 'span1'
  end

  def gear_time
#    handle_none logged_day.gear_time do
#      logged_day.gear_time
#    end
    best_in_place logged_day, :gear_time, type: :input, nil: '--', inner_class: 'span1'
  end

  def graticule
#    handle_none logged_day.graticule do
#      link_to logged_day.graticule.try(:code), logged_day.graticule 
#    end
    best_in_place logged_day, :graticule_id, type: :select, collection: Graticule.all.map{ |g| [g.id, g.code] }, display_as: :formatted_graticule, inner_class: 'span1'
  end

  def fuel
#    handle_none logged_day.fuel do
#      logged_day.fuel
#    end
    best_in_place logged_day, :fuel, type: :input, nil: '--', inner_class: 'span1'
  end

  def sail
#    handle_none logged_day.sail do
#      logged_day.sail.yn
#    end
    best_in_place logged_day, :sail, type: :checkbox, collection: [raw("<i class='icon-check-empty'></i>"), raw("<i class='icon-check'></i>")], inner_class: 'span1' 
  end

  def net 
#    handle_none logged_day.net do
#      logged_day.net.yn 
#    end
    best_in_place logged_day, :net, type: :checkbox, collection: [raw("<i class='icon-check-empty'></i>"), raw("<i class='icon-check'></i>")], inner_class: 'span1'
  end

  def line
#    handle_none logged_day.line do
#      logged_day.line.yn 
#    end
    best_in_place logged_day, :line, type: :checkbox, collection: [raw("<i class='icon-check-empty'></i>"), raw("<i class='icon-check'></i>")], inner_class: 'span1'
  end

  def fish
#    handle_none logged_day.fish do
#      link_to logged_day.fish.code, logged_day.fish, title: "#{logged_day.fish.scientific_name} - #{logged_day.fish.english_name}"
#    end
    best_in_place logged_day, :fish_id, type: :select, collection: Fish.all.map{ |f| [f.id, f.code] }, inner_class: 'span1'
  end

  def quantity
#    handle_none logged_day.quantity do
#      logged_day.quantity
#    end
    best_in_place logged_day, :quantity, type: :input, nil: '--', inner_class: 'span1'
  end

  def weight
#    handle_none logged_day.weight do
#      logged_day.weight
#    end
    best_in_place logged_day, :weight, type: :input, nil: '--', inner_class: 'span1'
  end

  def value 
#    handle_none logged_day.value do
#      logged_day.value
#    end
    best_in_place logged_day, :value, type: :input, nil: '--', inner_class: 'span1', display_with: :number_with_delimiter
  end

  def condition
#    handle_none logged_day.condition do
#      logged_day.condition_as_text
#    end
    conditions = [ [1, "Calm"], [2, "Moderate"], [3, "High"] ]
   # best_in_place logged_day, :condition, type: :input, nil: '--', inner_class: 'span1', display_as: :condition_as_text
    best_in_place logged_day, :condition, type: :select, collection: conditions, inner_class: 'span1'
  end



  private 

  def handle_none(value)
    if value.present?
      yield
    else
      content_tag :span, "--", class: "no-data"
    end
  end

end