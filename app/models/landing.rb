class Landing < ActiveRecord::Base
	attr_accessible :boat_size, :crew, :engine, :fuel, :gear_id, :grid_square, :quantity, :sail, :time_in, :time_out, :value, :vessel_name, :vessel_ref, :weight, :type,
	:power, :fishing_area, :survey_id

	belongs_to :gear
	belongs_to :survey

	has_many :catches, dependent: :destroy


	def self.import_from_email(params, user_id)
		params.flatten.each do |param|
			reg = param[:reg]
			name = param[:name]
			type = param[:type]
			engine = param[:engine]
			power = param[:power]
			fishing_area = param[:fishing_area]
			dep_time = param[:dep_time]
			arr_time = param[:arr_time]
			sail = param[:sail]
			fuel = param[:fuel]
			crew = param[:fuel]
			gear = param[:gear].downcase rescue ''
			weight = param[:weight]
			qty = param[:qty]
			value = param[:value]

			puts "ieu urang euyyyyyyyyy.........."
			puts reg
			puts "wokeeeeeeeeeeeee"
			unless reg.blank?
				gear_id = Gear.where("LOWER(code) = ?", gear).first.id rescue nil

				Landing.create(power: power, fishing_area: fishing_area, type: type, vessel_ref: reg, vessel_name: name, engine: engine, sail: sail,
					fuel: fuel, crew: crew, weight: weight, quantity: qty, value: value, time_in: arr_time,
					time_out: dep_time, gear_id: gear_id)
			end
		end
	end
end
