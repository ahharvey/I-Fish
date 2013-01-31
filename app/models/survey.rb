# == Schema Information
#
# Table name: surveys
#
#  id             :integer          not null, primary key
#  date_published :date
#  desa_id        :integer
#  start_time     :datetime
#  end_time       :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  fishery_id     :integer
#  fleet_observer :string(255)
#  catch_scribe   :string(255)
#  catch_measure  :string(255)
#  admin_id       :integer
#

class Survey < ActiveRecord::Base
	attr_accessible :date, :desa_id, :end_time, :fishery_id, :catch_measure,
	:fleet_observer, :catch_scribe, :start_time, :admin_id, :user_id, :date_published, :observer

	belongs_to :admin
	belongs_to :fishery
	belongs_to :desa
	has_many :landings
	has_one :district, through: :desa
	has_one :province, through: :district

#	validates :date_published,
#		presence: true
#	validates :desa_id,
#		presence: true
#	validates :start_time,
#		presence: true
#	validates :end_time,
#		presence: true
#	validates :fishery_id,
#		presence: true
#	validates :fleet_observer,
#		presence: true
#	validates :catch_scribe,
#		presence: true
#	validates :catch_measure,
#		presence: true
#	validates :admin_id,
#		presence: true

	def self.import_from_email(params,user_id)
		params.flatten.each do |param|
			fishery = param[:fishery] || ''
			kabupaten = param[:kabupaten] || ''
			code_desa = param[:code_desa] || ''
			date_published = param[:date_published] || ''
			start_time = param[:start_time] || ''
			end_time = param[:end_time] || ''
			fleet_observer = param[:fleet_observer] || ''
			catch_scribe = param[:catch_scribe] || ''
			catch_measure = param[:catch_measure] || ''

			unless fishery.blank?
				desa_id = Desa.where("LOWER(code) = ?", code_desa).first.id rescue nil
				fishery_id = Fishery.where("LOWER(code) = ?", fishery).first.id rescue nil

				puts Survey.create(fishery_id: fishery_id, desa_id: desa_id, date_published: date_published, 
					start_time: start_time, end_time: end_time, fleet_observer: fleet_observer,
					catch_scribe: catch_scribe, catch_measure: catch_measure, user_id: user_id)
			end
		end
	end
end
