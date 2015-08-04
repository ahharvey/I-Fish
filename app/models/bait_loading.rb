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

class BaitLoading < ActiveRecord::Base

  has_paper_trail
  
  belongs_to :vessel, touch: true
  belongs_to :fish, touch: true
  belongs_to :secondary_fish, class_name: 'Fish', foreign_key: 'secondary_fish_id'
  belongs_to :grid, touch: true
  belongs_to :unloading, touch: true
  belongs_to :bait, touch: true
  belongs_to :secondary_bait, class_name: 'Bait', foreign_key: 'secondary_bait_id'
  belongs_to :reviewer, :class_name => 'User'


  validates :vessel,
    presence: true
  validates :fish,
    presence: true
  validates :quantity,
    presence: true,
    numericality: {
      only_integer: true
    },
    inclusion: {
      in: 1..999
    }
  validates :method_type,
    presence: true
  validates :grid,
    presence: true



  METHOD_TYPES = ["bagan", "purse", "beach", "bouke"]

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
  
  attr_writer :formatted_date
  before_validation :save_formatted_date 
  validate :validates_date
  def formatted_date
    @formatted_date || date.try(:to_s, :long)
  end
  
  def save_formatted_date
    self.date = Chronic.parse(@formatted_date) if @formatted_date.present?
  end


  def self.completed_this_month
    BaitLoading.where( date: Date.today.beginning_of_month..Date.today.end_of_month ).size
  end

  def self.completed_last_month
    BaitLoading.where( date: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month ).size
  end

  def self.approved_this_month
    BaitLoading.where( date: Date.today.beginning_of_month..Date.today.end_of_month, review_state: 'approved' ).size
  end

  def self.approved_last_month
    BaitLoading.where( date: Date.today.beginning_of_month-1.month..Date.today.end_of_month-1.month, review_state: 'approved' ).size
  end

  private

  def validates_date
    if @formatted_date.present? && Chronic.parse(@formatted_date).nil?
      self.errors.add(:formatted_date, :invalid_date)
    end
  end
end
