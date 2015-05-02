collection @vessels, :object_root => false, :root => "vessels"

attributes :ap2hi_ref => :uvi, :material_type => :material, :machine_type => :engine

attributes :name, :flag_state, :year_built, :length, :tonnage, :crew, :hooks, :captain, :owner, :sipi_number, :sipi_expiry, :vms, :vms_alternative, :port


glue :gear do
  attributes :name => :gear
end

glue :vessel_type do
  attributes :name => :vessel_type
end