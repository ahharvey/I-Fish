class Landing < ActiveRecord::Base
  attr_accessible :boat_size, :crew, :engine, :fuel, :gear_id, :grid_square, :quantity, :sail, :time_in, :time_out, :value, :vessel_name, :vessel_ref, :weight
  
  belongs_to :gear
end
