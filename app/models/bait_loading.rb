# == Schema Information
#
# Table name: bait_loadings
#
#  id                :integer          not null, primary key
#  date              :date
#  vessel_id         :integer
#  location          :string
#  fish_id           :integer
#  quantity          :integer
#  unloading_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  price             :integer
#  method_type       :string
#  review_state      :string           default("pending")
#  grid_id           :integer
#  secondary_fish_id :integer
#

class BaitLoading < ApplicationRecord

  METHOD_TYPES = %w{ bagan purse beach bouke }

  has_paper_trail
  include Reviewable

  belongs_to :vessel, touch: true
  belongs_to :fish, touch: true
  belongs_to :secondary_fish, class_name: 'Fish', foreign_key: 'secondary_fish_id'
  belongs_to :grid, touch: true
  belongs_to :unloading, touch: true
  belongs_to :bait, touch: true
  belongs_to :secondary_bait, class_name: 'Bait', foreign_key: 'secondary_bait_id'
  belongs_to :reviewer, :class_name => 'User'

  scope :default,   -> { order('bait_loadings.date DESC') }
  scope :current,   -> { where( 'date >= ?', Date.today.beginning_of_year ) }

  scope :completed_this_month, -> { where( date: Date.today.beginning_of_month..Date.today.end_of_month ).size }
  scope :completed_last_month, -> { where( date: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month ).size }
  scope :uploaded_this_month, -> { where( created_at: Date.today.beginning_of_month..Date.today.end_of_month ).size }
  scope :uploaded_last_month, -> { where( created_at: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month ).size }
  scope :approved_this_month, -> { where( reviewed_at: Date.today.beginning_of_month..Date.today.end_of_month, review_state: 'approved' ).size }
  scope :approved_last_month, -> { where( reviewed_at: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month, review_state: 'approved' ).size }

  validates :vessel,
    presence: true
  validates :bait,
    presence: true
  validates :quantity,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 999
    }
  validates :method_type,
    inclusion: { in: METHOD_TYPES },
    allow_blank: true
#    presence: true
#  validates :grid,
#    presence: true







  attr_writer :formatted_date
  before_validation :save_formatted_date
  validate :validates_date
  def formatted_date
    @formatted_date || date.try(:to_s, :long)
  end

  def save_formatted_date
    self.date = Chronic.parse(@formatted_date) if @formatted_date.present?
  end




  def attributes_for_import_email

    vessel    = Vessel.find( vessel_id ).ap2hi_ref    rescue 'none'
    grid      = Grid.find( grid_id ).name             rescue 'none'
    loadDate  = date.try(:to_s, :long)
    bait1     = Bait.find( bait_id ).code             rescue 'none'
    bait2     = Bait.find( secondary_bait_id ).code   rescue 'none'


    {
      date: loadDate,
      vessel: vessel,
      method: method_type,
      grid: grid,
      quantity: quantity,
      price: price,
      primary: bait1,
      secondary: bait2
    }
  end

  private

  def validates_date
    if @formatted_date.present? && Chronic.parse(@formatted_date).nil?
      self.errors.add(:formatted_date, :invalid_date)
    end
  end

  def self.accessible_attributes
    [
      "date",
      "vessel_id",
      "method_type",
      "grid_id",
      "quantity",
      "price",
      "bait_id",
      "secondary_bait_id",
    ]
  end




end
