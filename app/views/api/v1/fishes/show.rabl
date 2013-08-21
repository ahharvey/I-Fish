object @fish

attributes :id, :order, :family, :scientific_name, :code, :a, :b, :mat, :max, :opt, :threatened

child :landings do
  attributes :gear_id, :cpue, :value
end
