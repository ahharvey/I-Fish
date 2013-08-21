object @gear

attributes :id, :name, :fao_code
attributes :cat_eng => :category, :sub_cat_eng => :sub_category, :type_eng => :type, :alpha_code => :mmaf_code, :num_code => :mmaf_number

child :approved_landings do
  attributes :id, :quantity, :weight, :cpue, :value, :cpue_kg, :cpue_idr, :cpue_fuel, :fuel, :crew
  glue :engine do 
    attributes :name => :engine
  end
end





