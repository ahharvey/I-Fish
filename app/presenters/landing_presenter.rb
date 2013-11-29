class LandingPresenter < BasePresenter
  presents :landing

  def vessel_ref
    handle_none landing.vessel_ref do
      landing.vessel_ref
    end
  end
     
  def vessel_name
    handle_none landing.vessel_name do
      landing.vessel_name
    end
  end
  
  def graticule
    handle_none landing.graticule do
      link_to landing.graticule.try(:code), landing.graticule 
    end
  end

  def vessel_type
    handle_none landing.vessel_type do
      link_to landing.vessel_type.try(:code).try(:upcase), landing.vessel_type 
    end
  end

  def time_out
    handle_none landing.time_out do
      landing.time_out.to_s(:triptime) 
    end
  end

  def time_in
    handle_none landing.time_in do
      landing.time_in.to_s(:triptime) 
    end
  end

  def engine
    handle_none landing.engine_id do
      link_to landing.engine.code, "#", title: landing.engine.name
    end
  end

  def fuel
    handle_none landing.fuel do
      landing.fuel 
    end
  end

  def sail
    handle_none landing.sail do
      landing.sail
    end
  end

  def crew
    handle_none landing.crew do
      landing.crew
    end
  end

  def boat_size
    handle_none landing.boat_size do
      landing.boat_size
    end
  end

  def gear
    handle_none landing.gear_id do
      link_to landing.gear.alpha_code, landing.gear, title:landing.gear.name
    end
  end

  def quantity
    handle_none landing.quantity do
      landing.quantity
    end
  end

  def weight
    handle_none landing.weight do
      landing.weight
    end
  end

  def value
    handle_none landing.value do
      landing.value
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