object @engine

attributes :id, :name, :code

child :approved_landings do
  attributes :id, :quantity, :weight, :cpue, :value, :cpue_kg, :cpue_idr, :cpue_fuel, :fuel, :crew
  glue :gear do 
    attributes :name => :gear
  end
end