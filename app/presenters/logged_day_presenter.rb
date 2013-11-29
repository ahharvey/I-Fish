class LoggedDayPresenter < BasePresenter
  presents :logged_day

  def start_date
    handle_none logged_day.start_time do
      logged_day.start_time.to_date.strftime("%d") 
    end
  end

  def start_time
    handle_none logged_day.start_time do
      logged_day.start_time.to_s(:time)
    end
  end

  def end_time
    handle_none logged_day.end_time do
      logged_day.end_time.to_s(:time)
    end
  end

  def gear_time
    handle_none logged_day.gear_time do
      logged_day.gear_time
    end
  end

  def graticule
    handle_none logged_day.graticule do
      link_to logged_day.graticule.try(:code), logged_day.graticule 
    end
  end

  def fuel
    handle_none logged_day.fuel do
      logged_day.fuel
    end
  end

  def sail
    handle_none logged_day.sail do
      logged_day.sail.yn
    end 
  end

  def net 
    handle_none logged_day.net do
      logged_day.net.yn 
    end
  end

  def line
    handle_none logged_day.line do
      logged_day.line.yn 
    end
  end

  def fish
    handle_none logged_day.fish do
      link_to logged_day.fish.code, logged_day.fish, title: "#{logged_day.fish.scientific_name} - #{logged_day.fish.english_name}"
    end
  end

  def quantity
    handle_none logged_day.quantity do
      logged_day.quantity
    end
  end

  def weight
    handle_none logged_day.weight do
      logged_day.weight
    end
  end

  def value 
    handle_none logged_day.value do
      logged_day.value
    end
  end

  def condition
    handle_none logged_day.condition do
      logged_day.condition_as_text
    end
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