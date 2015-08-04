class VesselPresenter < BasePresenter
  presents :vessel

  def code_of_conduct 
    handle_none vessel.code_of_conduct do
      if vessel.code_of_conduct?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

  def shark_policy
    handle_none vessel.shark_policy do
      if vessel.shark_policy?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

  def iuu_list 
    handle_none vessel.iuu_list do
      if vessel.iuu_list?
        icon fa_true
      else
        icon fa_false
      end
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