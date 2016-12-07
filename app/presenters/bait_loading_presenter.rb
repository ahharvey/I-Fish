class BaitLoadingPresenter < BasePresenter
  presents :bait_loading

  def date
    best_in_place bait_loading, :date, as: :input, place_holder: '--', inner_class: 'col-xs-1', display_as: :formatted_date
  end

  def ap2hi_ref
    best_in_place bait_loading, :vessel_id, as: :select, collection: Vessel.all.map{ |g| [g.id, g.ap2hi_ref] }, inner_class: 'col-xs-1'
  end

  def fish
    best_in_place bait_loading, :fish_id, as: :select, collection: Fish.all.map{ |g| [g.id, g.code] }, inner_class: 'col-xs-1'
  end

  def bait
    best_in_place bait_loading, :bait_id, as: :select, collection: Bait.all.map{ |g| [g.id, g.code] }, inner_class: 'col-xs-1'
  end

  def quantity
    best_in_place bait_loading, :quantity, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def location
    best_in_place bait_loading, :location, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def price
    best_in_place bait_loading, :price, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def method_type
    best_in_place bait_loading, :method_type, as: :select, collection: BaitLoading::METHOD_TYPES.map{ |s| [I18n.t("method_types.#{s}"), s] }, inner_class: 'col-xs-1'
  end

  def company_avatar
    handle_none bait_loading.company do
      bait_loading.company.try(:avatar).try(:file).try(:file)
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
