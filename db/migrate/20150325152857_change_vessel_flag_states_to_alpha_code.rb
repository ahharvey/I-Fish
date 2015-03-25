class ChangeVesselFlagStatesToAlphaCode < ActiveRecord::Migration
  def up
    Vessel.all.each do |v|
      if c = Country.find_country_by_name(v.flag_state)
        v.flag_state = c.alpha2
        v.save
      end
    end
  end
end
