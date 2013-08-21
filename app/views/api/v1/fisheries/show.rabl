object @fishery 

attributes :id, :code, :name

child :approved_surveys do
  attributes :date_published => :date, :start_time => :start, :end_time => :end, :fleet_observer => :enumerator_1, :catch_scribe => :enumerator_2, :catch_measure => :enumerator_3
  attributes :id, :approved

  child :admin => :approved_by do
    attributes :name, :id, :office_id
  end
end
