class Landing < ActiveRecord::Base
  attr_accessible :boat_size, :crew, :engine, :fuel, :gear_id, :grid_square, :quantity, :sail, :time_in, :time_out, :value, :vessel_name, :vessel_ref, :weight, :type,
    :power, :fishing_area
  
  belongs_to :gear
  has_many :catches, dependent: :destroy
end
