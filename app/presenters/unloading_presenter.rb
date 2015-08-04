class UnloadingPresenter < BasePresenter
  presents :unloading



  def port
    best_in_place_if (can? :edit, unloading), unloading, :wpp, as: :select, collection: Port.all.map{ |g| [g.id, g.name] }, inner_class: 'col-xs-1'
  end

  def time_out
    best_in_place_if (can? :edit, unloading), unloading, :time_out, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_as: :short_time_out
  end

  def time_in
    best_in_place_if (can? :edit, unloading), unloading, :time_in, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_as: :short_time_in
  end

  def yft
    best_in_place_if (can? :edit, unloading), unloading, :yft, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def bet
    best_in_place_if (can? :edit, unloading), unloading, :bet, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def skj
    best_in_place_if (can? :edit, unloading), unloading, :skj, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def kaw
    best_in_place_if (can? :edit, unloading), unloading, :kaw, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def byproduct
    best_in_place_if (can? :edit, unloading), unloading, :byproduct, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def discard
    best_in_place_if (can? :edit, unloading), unloading, :discard, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def etp
    best_in_place_if (can? :edit, unloading), unloading, :etp, as: :checkbox, collection: { false: raw("<i class='fa fa-square-o'></i>"), true: raw("<i class='fa fa-check-square-o'></i>") }, inner_class: 'col-xs-1' 
  end

  def location
    best_in_place_if (can? :edit, unloading), unloading, :location, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def fuel
    best_in_place_if (can? :edit, unloading), unloading, :fuel, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def ice
    best_in_place_if (can? :edit, unloading), unloading, :ice, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def wpp
    best_in_place_if (can? :edit, unloading), unloading, :wpp, as: :select, collection: Wpp.all.map{ |g| [g.id, g.name] }, inner_class: 'col-xs-1'
  end

  def company
    handle_none unloading.company do
      unloading.company.try(:name)
    end
  end

  def user
    handle_none unloading.user do
      unloading.user.try(:name)
    end
  end

  def vessel
    best_in_place_if (can? :edit, unloading), unloading, :wpp, as: :select, collection: Vessel.all.map{ |g| [g.id, g.ap2hi_ref] }, inner_class: 'col-xs-1'
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