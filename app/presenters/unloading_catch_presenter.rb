class UnloadingCatchPresenter < BasePresenter
  presents :unloading_catch

  def fish
  	best_in_place_if (can? :edit, unloading_catch), unloading_catch, :fish, as: :select, collection: Fish.default.map{ |f| [f.id, f.code] }, inner_class: 'col-xs-1'
  end

  def quantity
  	best_in_place_if (can? :edit, unloading_catch), unloading_catch, :quantity, as: :input, place_holder: '--', inner_class: 'col-xs-1'
  end

  def cut_type
  	best_in_place_if (can? :edit, unloading_catch), unloading_catch, :cut_type, as: :select, collection: UnloadingCatch::CUT_TYPES.map { |s| [s, I18n.t("cut_types.#{s}")] }, inner_class: 'col-xs-1'
  end

  def type
  	best_in_place_if (can? :edit, unloading_catch), unloading_catch, :type, as: :select, collection: UnloadingCatch::CATCH_TYPES.map{ |t| [t, I18n.t("catch_types.#{t}")] }, inner_class: 'col-xs-1'
  end

  def size_class
  	best_in_place_if (can? :edit, unloading_catch), unloading_catch, :size_class, as: :select, collection: SizeClass.default.map{ |sc| [sc.id, sc.name] }, inner_class: 'col-xs-1'
  end

end

