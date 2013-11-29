class CatchPresenter < BasePresenter
  presents :catch

  def fish 
    handle_none catch.fish_id do
      link_to catch.fish.code, catch.fish, title: "#{catch.fish.scientific_name} - #{catch.fish.english_name}"
    end
  end
  
  def length
    handle_none catch.length do
      catch.length 
    end
  end

  def vessel_name
    handle_none catch.landing.vessel_name do
      catch.landing.vessel_name 
    end
  end

  def sfactor
    handle_none catch.sfactor do
      catch.sfactor 
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