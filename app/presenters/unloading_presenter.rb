class UnloadingPresenter < BasePresenter
  presents :unloading

  def port
    best_in_place unloading, :port, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def time_out
    best_in_place unloading, :time_out, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_as: :formatted_time_out
  end

  def time_in
    best_in_place unloading, :time_in, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_as: :formatted_time_in
  end

  def yft
    best_in_place unloading, :yft, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def bet
    best_in_place unloading, :bet, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def skj
    best_in_place unloading, :skj, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def kaw
    best_in_place unloading, :kaw, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def byproduct
    best_in_place unloading, :byproduct, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def discard
    best_in_place unloading, :discard, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def etp
    best_in_place unloading, :etp, as: :checkbox, collection: { false: raw("<i class='fa fa-square-o'></i>"), true: raw("<i class='fa fa-check-square-o'></i>") }, inner_class: 'col-xs-1' 
  end

  def location
    best_in_place unloading, :location, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def fuel
    best_in_place unloading, :fuel, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def ice
    best_in_place unloading, :ice, as: :input, place_holder: '--', inner_class: 'col-xs-1'
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