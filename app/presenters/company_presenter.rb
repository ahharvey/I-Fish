class CompanyPresenter < BasePresenter
  presents :company

  def member 
    handle_none company.member do
      if company.member?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

  def code_of_conduct 
    handle_none company.code_of_conduct do
      if company.code_of_conduct?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

  def shark_policy
    handle_none company.shark_policy do
      if company.shark_policy?
        icon fa_true
      else
        icon fa_false
      end
    end
  end

  def iuu_list 
    handle_none company.iuu_list do
      if company.iuu_list?
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