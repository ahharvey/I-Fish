collection @desas, :root => "landing sites", :object_root => false

attributes :id, :code, :name
attributes :lat => :latitude, :lng => :longitude

glue :district do
  attributes :name => :district
end

glue :province do
  attributes :name => :province
end

