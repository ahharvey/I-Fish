# == Schema Information
#
# Table name: landings
#
#  id           :integer          not null, primary key
#  power        :string(255)
#  fishing_area :string(255)
#  vessel_ref   :string(255)
#  vessel_name  :string(255)
#  grid_square  :string(255)
#  engine       :string(255)
#  fuel         :string(255)
#  sail         :string(255)
#  crew         :string(255)
#  value        :string(255)
#  boat_size    :integer
#  gear_id      :integer
#  survey_id    :integer
#  quantity     :integer
#  weight       :integer
#  time_out     :datetime
#  time_in      :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  type         :string(255)
#

class Landing < ActiveRecord::Base
	attr_accessible :boat_size, :crew, :engine, :fuel, :gear_id, :grid_square, :quantity, :sail, :time_in, :time_out, :value, :vessel_name, :vessel_ref, :weight, :type,
	:power, :fishing_area, :survey_id

	set_inheritance_column nil

	belongs_to :gear
	belongs_to :survey

	has_many :catches, dependent: :destroy

	validates :power,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999
		}
	validates :fishing_area,
		presence: true
	validates :vessel_ref,
		presence: true
	validates :vessel_name,
		presence: true
	validates :engine,
		presence: true,
		inclusion: {
			in: %w(outboard inboard long-tail)
		}
	validates :fuel,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999
		}
	validates :sail,
		presence: true,
		inclusion: {
			in: %w(Y N)
		}
	validates :crew,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..49
		}
	validates :value,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999999999
		}
	validates :boat_size,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999
		}
	validates :gear_id,
		presence: true
	validates :survey_id,
		presence: true
	validates :quantity,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..9999
		}
	validates :weight,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999999
		}
	validates :time_out,
		presence: true
	validtates :time_in,
		presence: true
	validates :type,
		presence: true


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

			unless reg.blank?
				gear_id = Gear.where("LOWER(code) = ?", gear).first.id rescue nil

				puts Landing.create(power: power, fishing_area: fishing_area, type: type, vessel_ref: reg, vessel_name: name, engine: engine, sail: sail,
					fuel: fuel, crew: crew, weight: weight, quantity: qty, value: value, time_in: arr_time,
					time_out: dep_time, gear_id: gear_id)
			end
		end
	end
end
