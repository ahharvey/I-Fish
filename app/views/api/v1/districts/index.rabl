collection @districts, :object_root => false

attributes :id, :code, :name

glue :province do
  attributes :name => :province
end

