class LoggedDayPresenter < BasePresenter
  presents :logged_day

  def start_date
#    handle_none logged_day.start_time do
#      logged_day.start_time.to_date.strftime("%d") 
#    end
    best_in_place logged_day, :date_input, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_as: :formatted_date
  end

  def start_time
#    handle_none logged_day.start_time do
#      logged_day.start_time.to_s(:time)
#    end
    best_in_place logged_day, :start_time_input, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def end_time
#    handle_none logged_day.end_time do
#      logged_day.end_time.to_s(:time)
#    end
    best_in_place logged_day, :end_time_input, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def gear_time
#    handle_none logged_day.gear_time do
#      logged_day.gear_time
#    end
    best_in_place logged_day, :gear_time, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def graticule
#    handle_none logged_day.graticule do
#      link_to logged_day.graticule.try(:code), logged_day.graticule 
#    end
    best_in_place logged_day, :graticule_id, as: :select, collection: Graticule.all.map{ |g| [g.id, g.code] }, display_as: :formatted_graticule, inner_class: 'col-xs-1'
  end

  def fuel
#    handle_none logged_day.fuel do
#      logged_day.fuel
#    end
    best_in_place logged_day, :fuel, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def sail
#    handle_none logged_day.sail do
#      logged_day.sail.yn
#    end
    best_in_place logged_day, :sail, as: :checkbox, collection: { false: raw("<i class='fa fa-square-o'></i>"), true: raw("<i class='fa fa-check-square-o'></i>") }, inner_class: 'col-xs-1' 
  end

  

  def net 
#    handle_none logged_day.net do
#      logged_day.net.yn 
#    end
    best_in_place logged_day, :net, as: :checkbox, collection: { false: raw("<i class='fa fa-square-o'></i>"), true: raw("<i class='fa fa-check-square-o'></i>") }, inner_class: 'col-xs-1'
  end

  def line
#    handle_none logged_day.line do
#      logged_day.line.yn 
#    end
    best_in_place logged_day, :line, as: :checkbox, collection: { false: raw("<i class='fa fa-square-o'></i>"), true: raw("<i class='fa fa-check-square-o'></i>") }, inner_class: 'col-xs-1'
  end

  def fish
#    handle_none logged_day.fish do
#      link_to logged_day.fish.code, logged_day.fish, title: "#{logged_day.fish.scientific_name} - #{logged_day.fish.english_name}"
#    end
    best_in_place logged_day, :fish_id, as: :select, collection: Fish.all.map{ |f| [f.id, f.code] }, inner_class: 'col-xs-1'
  end

  def quantity
#    handle_none logged_day.quantity do
#      logged_day.quantity
#    end
    best_in_place logged_day, :quantity, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def weight
#    handle_none logged_day.weight do
#      logged_day.weight
#    end
    best_in_place logged_day, :weight, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def value 
#    handle_none logged_day.value do
#      logged_day.value
#    end
    best_in_place logged_day, :value, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_with: :number_with_delimiter
  end

  def condition
#    handle_none logged_day.condition do
#      logged_day.condition_as_text
#    end
    conditions = [ [1, "Calm"], [2, "Moderate"], [3, "High"] ]
   # best_in_place logged_day, :condition, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_as: :condition_as_text
    best_in_place logged_day, :condition, as: :select, collection: conditions, inner_class: 'col-xs-1'
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