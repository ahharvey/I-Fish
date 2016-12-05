# == Schema Information
#
# Table name: unloadings
#
#  id                :integer          not null, primary key
#  port              :string
#  time_out          :datetime
#  time_in           :datetime
#  etp               :boolean
#  location          :string
#  fuel              :integer
#  ice               :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  vessel_id         :integer
#  review_state      :string           default("pending")
#  byproduct         :integer
#  discard           :integer
#  yft               :integer
#  bet               :integer
#  skj               :integer
#  kaw               :integer
#  catch_certificate :string
#  budget            :integer
#  grid_id           :integer
#

class Unloading < ApplicationRecord

  has_paper_trail
  include Reviewable

  belongs_to :vessel
  has_one :company, through: :vessel
  belongs_to :wpp
  belongs_to :port
  belongs_to :user
  belongs_to :reviewer, :class_name => 'Admin'
  has_many :unloading_catches
  has_many :fish, -> {distinct}, through: :unloading_catches
  accepts_nested_attributes_for :unloading_catches, allow_destroy: true, reject_if: :all_blank
  has_many :bait_loadings
  accepts_nested_attributes_for :bait_loadings, allow_destroy: true, reject_if: :all_blank

  scope :default, -> { order('unloadings.time_in DESC') }
  scope :current, -> { where( 'unloadings.time_in >= ?', Date.today.beginning_of_year ) }

  validates :vessel,
    presence: true
  validates :port,
    presence: true
  validates :wpp,
    presence: true
  validates :time_out,
    timeliness: {
      type: :datetime,
      allow_blank: true
    }
  validates :time_in,
    timeliness: {
      on_or_after: :time_out,
      type: :datetime,
      allow_blank: true
    }


  before_save :set_cpue


#  validates :yft, :bet, :skj, :kaw, :byproduct, :discard, :fuel, :ice,
#    presence: {
#      message: " cannot be blank."
#    },
#    numericality: {
#      message: " is not a number."
#    }



#  def formatted_time_out
#    time_out.try(:strftime, "%d-%b-%Y %H:%M")
#  end#

#  def formatted_time_in
#    time_in.try(:strftime, "%d-%b-%Y %H:%M")
#  end

  attr_writer :formatted_time_out
  before_validation :save_formatted_time_out
  def formatted_time_out
    @formatted_time_out || time_out.try(:to_s, :long)
  end

  def save_formatted_time_out
    self.time_out = Chronic.parse(@formatted_time_out) if @formatted_time_out.present?
  end

  def short_time_out
    time_out.try(:to_s, :short)
  end

  def long_time_out
    time_out.try(:to_s, :sdate)
  end

  attr_accessor :wpp_code, :port_code
  def wpp_code=(code)
    if Wpp.where(name: code).any?
      self.wpp_id = Wpp.where(name: code).first.try(:id)
    else
      self.errors.add(:wpp_code, :invalid_wpp_code)
    end
  end

  def wpp_code
    self.wpp.try(:name)
  end

  def port_code=(code)
    if Port.where(name: code).any?
      self.port_id = Port.where(name: code).first.try(:id)
    else
      self.errors.add(:port_code, :invalid_port_code)
    end
  end

  def port_code
    self.port.try(:name)
  end

  attr_writer :formatted_time_in
  before_validation :save_formatted_time_in
  def formatted_time_in
    @formatted_time_in || time_in.try(:to_s, :long)
  end

  def save_formatted_time_in
    self.time_in = Chronic.parse(@formatted_time_in) if @formatted_time_in.present?
  end

  def short_time_in
    time_in.try(:to_s, :short)
  end

  def long_time_in
    time_in.try(:to_s, :sdate)
  end

  def number_of_bait_loadings
    Rails.cache.fetch(["bait-loadings", self], expires_in: 5.minutes) do
      bait_loadings.length
    end
  end



  def self.completed_this_month
    Unloading.where( time_in: Date.today.beginning_of_month..Date.today.end_of_month ).size
  end

  def self.completed_last_month
    Unloading.where( time_in: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month ).size
  end

  def self.uploaded_this_month
    Unloading.where( created_at: Date.today.beginning_of_month..Date.today.end_of_month ).size
  end

  def self.uploaded_last_month
    Unloading.where( created_at: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month ).size
  end

  def self.approved_this_month
    Unloading.where( reviewed_at: Date.today.beginning_of_month..Date.today.end_of_month, review_state: 'approved' ).size
  end

  def self.approved_last_month
    Unloading.where( reviewed_at: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month, review_state: 'approved' ).size
  end


  def komu_kg=(value)
    fish = Fish.find_by(code: 'KAW')
    build_unloading_record(fish, value)
  end

  def kaw_kg=(value)
    fish = Fish.find_by(code: 'KAW')
    build_unloading_record(fish, value)
  end

  def bet_kg=(value)
    fish = Fish.find_by(code: 'BET')
    build_unloading_record(fish, value)
  end

  def yft_kg=(value)
    fish = Fish.find_by(code: 'YFT')
    build_unloading_record(fish, value)
  end

  def skj_kg=(value)
    fish = Fish.find_by(code: 'SKJ')
    build_unloading_record(fish, value)
  end

  def build_unloading_record(fish, value)
    self.unloading_catches.build(
      fish_id: fish.id,
      quantity: value,
      cut_type: 'wholeround',
      catch_type: 'landed'
      )
  end

  def komo_kg
    Rails.cache.fetch(["komo_kg", self], expires_in: 5.minutes) do
      fishId  = Fish.find_by(code: 'KAW').id
      calculate_production_for( fishId )
    end
  end

  def kaw_kg
    Rails.cache.fetch(["kaw_kg", self], expires_in: 5.minutes) do
      fishId  = Fish.find_by(code: 'KAW').id
      calculate_production_for( fishId )
    end
  end

  def bet_kg
    Rails.cache.fetch(["bet_kg", self], expires_in: 5.minutes) do
      fishId  = Fish.find_by(code: 'BET').id
      calculate_production_for( fishId )
    end
  end

  def yft_kg
    Rails.cache.fetch(["yft_kg", self], expires_in: 5.minutes) do
      fishId  = Fish.find_by(code: 'YFT').id
      calculate_production_for( fishId )
    end
  end

  def skj_kg
    Rails.cache.fetch(["skj_kg", self], expires_in: 5.minutes) do
      fishId  = Fish.find_by(code: 'SKJ').id
      calculate_production_for( fishId )
    end
  end

  def calculate_production_for( fishId )
    unloading_catches.where(fish_id: fishId ).sum(:quantity)
  end

  def attributes_for_import_email

    vessel    = Vessel.find( vessel_id ).ap2hi_ref  rescue 'none'
    port      = Port.find( port_id ).name           rescue 'none'
    wpp       = Wpp.find( wpp_id ).name             rescue 'none'
    timeout  = time_out.try(:to_s, :long)
    timein   = time_in.try(:to_s, :long)
    etpBool  = etp.present? ? 'Yes' : 'No'

    {
      vessel: vessel,
      port: port,
      wpp: wpp,
      time_out: timeout,
      time_in: timein,
      etp: etpBool,
      fuel: fuel,
      ice: ice
    }
  end

  #private

  def set_cpue
#    f     = Fish.find_by(code: 'SKJ')
#    c     = unloading_catches.where(fish_id: f.id )
#    t     = c.sum(:quantity)
#    d     = (time_in - time_out )/60/60/24
#    gt    = vessel.try(:tonnage).to_i || 0
#    cpue  = t / d / gt
  end

  def self.accessible_attributes
    [
      'time_out',
      'time_in',
      'port_code',
      'wpp_code',
      'etp',
      'fuel',
      'ice',
      'bet_kg',
      'komu_kg',
      'kaw_kg',
      'yft_kg',
      'skj_kg'
    ]
  end

  def self.to_monthly_fuel_utilization
    data = [['Fuel', 'Catch']]
    self.all.each do |unl|
      data << [unl.fuel, unl.unloading_catches.sum(:quantity)] unless unl.fuel.nil?
    end
    data
  end


end
