class Api::V1::UnloadingSerializer < ActiveModel::Serializer
  has_many :unloading_catches
  attributes :id, :time_out, :time_in, :etp, :fuel, :ice, :vessel_id, :port_id, :wpp_id

  class UnloadingCatchSerializer < ActiveModel::Serializer
    attributes :species, :quantity, :cut_type, :catch_type, :size_class
    def species
      object.fish.try(:code)
    end
    def size_class
      object.size_class.try(:name)
    end
  end
end
