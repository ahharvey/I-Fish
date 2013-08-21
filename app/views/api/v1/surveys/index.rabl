collection @surveys, :object_root => false

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

