object @logbook

attributes :id, :date

child :reviewer => :reviewed_by do
  attributes :id, :name
  glue :office do
    attributes :name => :office
  end
end

child :user => :fisherman do
  attributes :id, :name
end

glue :fishery do
  attributes :name => :fishery
end

child :logged_days => :days do
  attributes :id, :fuel, :sail, :net, :line, :quantity, :weight, :value, :condition, :crew
  attributes :start_time => :start, :end_time => :end
  child :fish do
    attributes :scientific_name => :species
  end
end
