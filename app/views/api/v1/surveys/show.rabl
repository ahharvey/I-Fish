object @survey

attributes :date_published => :date, :start_time => :start, :end_time => :end, :fleet_observer => :enumerator_1, :catch_scribe => :enumerator_2, :catch_measure => :enumerator_3
attributes :id

child :admin => :approved_by do
  attributes :name, :id, :office_id
end

glue :desa do
  attributes :name => :landing_site
end

glue :district do
  attributes :name => :district
end

glue :province do
  attributes :name => :province
end

glue :fishery do
  attributes :name => :fishery
end

child :landings do
  attributes :id, :quantity, :weight, :cpue, :value, :cpue_kg, :cpue_idr, :cpue_fuel, :fuel, :crew
  
  glue :gear do 
    attributes :name => :gear
  end

  glue :engine do 
    attributes :name => :engine
  end

  child :catches do 
    attributes :id, :length

    glue :fish do
      attributes :scientific_name => :species
    end
    
  end
end