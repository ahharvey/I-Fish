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
#  approved       :boolean          default(FALSE), not null
#  approver_id    :integer
#

class Survey < ActiveRecord::Base
	
	has_paper_trail

	attr_accessible :desa_id, 
									:end_time, 
									:fishery_id, 
									:start_time, 
									:admin_id, 
									:user_id, 
									:date_published, 
									:observer, 
									:approved,
									:catch_measurer_id,
									:catch_scribe_id,
									:landing_enumerator_id,
									:vessel_count

	belongs_to :admin
	belongs_to :approver, class_name: 'Admin'
	belongs_to :landing_enumerator, class_name: 'Admin'
	belongs_to :catch_measurer, class_name: 'Admin'
	belongs_to :catch_scribe, class_name: 'Admin'
	belongs_to :fishery
	belongs_to :desa
	has_many :landings
	has_many :catches, through: :landings
	has_many :fishes, through: :landings
	has_one :district, through: :desa
	has_one :province, through: :district

	validates :date_published,
		presence: {
			message: " is not defined." 
		}
	validates :desa,
		presence: {
			message: " is not recognized." 
		}
	validates :start_time,
		presence: {
			message: " is not defined." 
		}
	validates :end_time,
		presence: {
			message: " is not defined." 
		}
	validates :fishery,
		presence: {
			message: " is not recognized." 
		}
	validates :admin,
		presence: {
			message: " is not recognized." 
		}
	validates :landing_enumerator, 
		presence: {
			message: " is not recognized." 
		}
	validates :catch_scribe, 
		presence: {
			message: " is not recognized." 
		}
	validates :catch_measurer, 
		presence: {
			message: " is not recognized." 
		}
	validates :vessel_count, 
		numericality: {
      message: " is not a number."
    }

#	validate :uniqueness_of_survey

	def uniqueness_of_survey
		# TODO: Is there a better way of doing this?
		if Survey.where(self.attributes.slice(:date_published, :desa_id, :start_time, :end_time, :fishery_id, :start_time)).count != 0
			errors.add(:base, "Survey has been uploaded already.")
		end
	end
	
	after_create :format_approval_mail

	def format_approval_mail
		Survey.send_approval_mail( id )
	end
	def self.send_approval_mail(survey_id)
    #UserMailer.new_data_waiting_for_approval(survey_id).deliver
  end

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

	def self.completed_this_month
    Survey.where( date_published: Date.today.beginning_of_month..Date.today.end_of_month ).size
  end

  def self.completed_last_month
    Survey.where( date_published: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month ).size
  end

end
