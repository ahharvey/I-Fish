# == Schema Information
#
# Table name: surveys
#
#  id                    :integer          not null, primary key
#  date_published        :date
#  desa_id               :integer
#  start_time            :datetime
#  end_time              :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  fishery_id            :integer
#  admin_id              :integer
#  reviewer_id           :integer
#  landing_enumerator_id :integer
#  catch_measurer_id     :integer
#  catch_scribe_id       :integer
#  vessel_count          :integer
#  review_state          :string(255)      default("pending")
#  reviewed_at           :datetime
#

class Survey < ActiveRecord::Base
	
	has_paper_trail

	belongs_to :admin
	belongs_to :reviewer, class_name: 'Admin'
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

  attr_writer :start_time_input, :end_time_input

  before_save :save_start_at, :save_end_at  
  validate :check_start_at if @start_time_input.present?
  validate :check_end_at if @end_time_input.present?

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
	
	STATES = %w{ pending rejected approved }

  STATES.each do |state|
    define_method("#{state}?") do
      self.review_state == state
    end

    define_method("#{state}!") do
      self.update_attributes(
        review_state: state,
        reviewed_at: DateTime.now
        )
    end
  end

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

  def self.approved_this_month
    Survey.where( date_published: Date.today.beginning_of_month..Date.today.end_of_month, review_state: 'approved' ).size
  end

  def self.approved_last_month
    Survey.where( date_published: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month, review_state: 'approved' ).size
  end

  def formatted_fishery
    fishery.name
  end

  def formatted_desa
    desa.name
  end

  def formatted_date
    date_published.to_s(:rfc822)
  end

  def formatted_start_time
    start_time.to_s(:time)
  end

  def formatted_end_time
    end_time.to_s(:time)
  end

  def start_time_input
    @start_time_input || start_time.try(:strftime, "%H:%M")
  end

  # handles setting of end time
  def end_time_input
    @end_time_input || end_time.try(:strftime, "%H:%M")
  end
  
  # combines time and date to set value of start_time 
  def save_start_at
    self.start_time = Time.zone.parse("#{date_published} #{@start_time_input}" ) if ( @start_time_input.present? && date_published.present? )
  end

  # combines time and date to set value of end_time 
  def save_end_at
    self.end_time = Time.zone.parse("#{date_published} #{@end_time_input}" ) if ( @end_time_input.present? && date_published.present? )
  end
  
  # validates start time
  def check_start_at
    if  ( @start_time_input.present? && date_published.present? ) && Time.zone.parse( "#{date_published} #{@start_time_input}" ).nil?
      errors.add :start_time, "cannot be parsed"
    elsif @start_time_input.present? && !date_published.present?
      errors.add :date_published, "cannot be blank"
    elsif !@start_time_input.present? && date_published.present?
      errors.add :start_time, "cannot be blank"
    end
  rescue ArgumentError
    errors.add :start_time, "is not defined"   
  end

  # validates end time
  def check_end_at
    if  ( @end_time_input.present? && date_published.present? ) && Time.zone.parse( "#{date_published} #{@end_time_input}" ).nil?
      errors.add :end_time, "cannot be parsed"
    elsif @end_time_input.present? && !date_published.present?
      errors.add :date_published, "cannot be blank"
    elsif !@end_time_input.present? && date_published.present?
      errors.add :end_time, "cannot be blank"
    end
  rescue ArgumentError
    errors.add :end_time, "is not defined"   
  end

  def formatted_admin
    admin.name
  end

  def formatted_landing_enumerator
    landing_enumerator.name
  end

  def formatted_catch_measurer
    catch_measurer.name
  end

  def formatted_catch_scribe
    catch_scribe.name
  end
end
