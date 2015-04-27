
class CarrierLoadingPresenter < BasePresenter
  presents :carrier_loading

  def date
    best_in_place carrier_loading, :date, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_as: :formatted_date
  end

  def ap2hi_ref
    best_in_place carrier_loading, :vessel_id, as: :select, collection: Vessel.all.map{ |g| [g.id, g.ap2hi_ref] }, inner_class: 'col-xs-1'
  end

  def fish
    best_in_place carrier_loading, :fish_id, as: :select, collection: Fish.all.map{ |g| [g.id, g.code] }, inner_class: 'col-xs-1'
  end
  
  def quantity
    best_in_place carrier_loading, :quantity, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def location
    best_in_place carrier_loading, :location, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def size
    best_in_place carrier_loading, :size, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def grade
    best_in_place bait_loading, :grade, as: :input, place_holder: '--', inner_class: 'col-xs-1'
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