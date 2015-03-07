# == Schema Information
#
# Table name: landings
#
#  id           :integer          not null, primary key
#  vessel_ref   :string(255)
#  vessel_name  :string(255)
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
#  cpue         :integer
#  value        :integer
#  cpue_kg      :integer
#  cpue_idr     :integer
#  cpue_fuel    :integer
#  sail         :boolean
#  fuel         :integer
#  power        :integer
#  crew         :integer
#

class Landing < ActiveRecord::Base
	
	has_paper_trail

	self.inheritance_column = nil

	belongs_to :gear
	belongs_to :survey
	belongs_to :graticule
	belongs_to :engine
	belongs_to :fish
	belongs_to :vessel_type
	has_many :fishes, through: :catches
	has_one :province, through: :survey
	has_one :district, through: :survey
	has_one :fishery, through: :survey
	has_one :desa, through: :survey

	has_many :catches, dependent: :destroy

	#before_save :calculate_cpue

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
# validates :vessel_ref,
#		presence: true
	validates :vessel_name,
		presence: true
	validates :boat_size,
		presence: true
	validates :engine,
		presence: {
			message: " is not valid" 
		}
	validates :fuel,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 0..999
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
			in: 0..1000000000
		}
#	validates :boat_size,
#		presence: true,
#		numericality: {
#			only_integer: true
#		},
#		inclusion: {
#			in: 1..999
#		}
	validates :gear, 
		presence: {
			message: " is not recognized." 
		}
	validates :fish, 
		presence: {
			message: " is not recognized." 
		}
	# Do not validate presence of survey_id if this model is being imported from an excel file
	# as the parent survey will be saved later and currently doesn't have an ID.
	validates :survey_id,
		presence: true,
		:if => :not_importing
	validates :quantity,
		numericality: {
			only_integer: true,
			message: " is not a number."
		},
		inclusion: {
			in: 0..9999,
			message: " is too high."
		}
	validates :weight,
		numericality: {
			only_integer: true,
			message: " is not a number."
		},
		inclusion: {
			in: 0..999999,
			message: " is too high."
		},
		allow_nil: true
	validates :time_out,
		presence: true
	validates :time_in,
		presence: true
	validates :conditions,
		presence: true,
		inclusion: {
			in: 1..3
		}
	validates :ice,
		numericality: {
				only_integer: true
			},
		inclusion: {
			in: 0..99
		}
#	validates :type,
#		presence: true

	@@condition_data = { 1 => "Calm" , 2 => "Moderate" , 3 => "High" }
  
  def condition_as_text
    @@condition_data[conditions]
  end

	def calculate_cpue
		unless quantity.nil?
			self.cpue = quantity / ( ( ( time_in - time_out ) * crew ) / 1.hour ) 
		end
#		self.cpue_kg = weight.to_i / ( ( ( time_in.to_i - time_out.to_i ) * crew.to_i ) / 1.hour ) 
		#self.cpue_idr = ( self.value.to_i * self.weight.to_i ) / ( ( self.time_in.to_i - self.time_out.to_i ) / 1.hour )
		#self.cpue_fuel = weight.to_i / fuel.to_i
	end

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
