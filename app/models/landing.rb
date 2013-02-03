# == Schema Information
#
# Table name: landings
#
#  id           :integer          not null, primary key
#  power        :string(255)
#  vessel_ref   :string(255)
#  vessel_name  :string(255)
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
#  engine_id    :integer
#  graticule_id :integer
#  fish_id      :integer
#

class Landing < ActiveRecord::Base
	attr_accessible :boat_size, :crew, :fuel, :gear_id, :quantity, :sail, :time_in, :time_out, :value, :vessel_name, :vessel_ref, :weight, :type,
	:power, :graticule_id, :engine_id, :survey_id, :fish_id, :importing?, :cpue

	set_inheritance_column nil

	belongs_to :gear
	belongs_to :survey
	belongs_to :graticule
	belongs_to :engine
	belongs_to :fish
	has_one :district, through: :survey
	has_one :fishery, through: :survey
	has_one :desa, through: :survey

	has_many :catches, dependent: :destroy

	validates :power,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999
		}
	validates :graticule_id,
		presence: true
	validates :vessel_ref,
		presence: true
	validates :vessel_name,
		presence: true
	validates :boat_size,
		presence: true
	validates :engine_id,
		presence: true
	validates :fuel,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999
		}
	validates :sail,
		inclusion: {
			in: %w(Y N)
		}
	validates :crew,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..49
		}
	validates :value,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999999999
		}
#	validates :boat_size,
#		presence: true,
#		numericality: {
#			only_integer: true
#		},
#		inclusion: {
#			in: 1..999
#		}
	validates :gear_id,
		presence: true
	# Do not validate presence of survey_id if this model is being imported from an excel file
	# as the parent survey will be saved later and currently doesn't have an ID.
	validates :survey_id,
		presence: true,
		:if => :not_importing
	validates :quantity,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..9999
		}
	validates :weight,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999999
		}
	validates :time_out,
		presence: true
	validates :time_in,
		presence: true
#	validates :type,
#		presence: true

	def importing!
		@importing = true
	end

	def not_importing
		!@importing
	end

	def self.import_from_email(params, user_id)
		params.flatten.each do |param|
			reg = param[:reg]
			name = param[:name]
			type = param[:type]
			engine = param[:engine]
			power = param[:power]
			graticule_id = param[:graticule_id]
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

				puts Landing.create(power: power, graticule_id: graticule_id, type: type, vessel_ref: reg, vessel_name: name, engine_id: engine_id, sail: sail,
					fuel: fuel, crew: crew, weight: weight, quantity: qty, value: value, time_in: arr_time,
					time_out: dep_time, gear_id: gear_id)
			end
		end
	end
end
