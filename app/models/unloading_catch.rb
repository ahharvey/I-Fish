# == Schema Information
#
# Table name: unloading_catches
#
#  id           :integer          not null, primary key
#  fish_id      :integer
#  quantity     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  unloading_id :integer
#  cut_type     :string
#

class UnloadingCatch < ApplicationRecord
  CUT_TYPES = ["wholeround", "dirtyloin", "cleanloin", "gg"]

  CATCH_TYPES = ['landed', 'discarded']

  belongs_to :fish
  belongs_to :unloading #, required: true
  belongs_to :size_class
  has_one :vessel, through: :unloading

  scope :default, -> { joins(:fish).order('fishes.code ASC') }
  scope :current, -> { joins(:unloading).where( 'unloadings.time_in >= ?', Date.today.beginning_of_year ) }

  validates :fish,
  	presence: true
  validates :unloading,
  	presence: true
  validates :quantity,
  	presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 9999
    }
  validates :catch_type,
    inclusion: { in: CATCH_TYPES },
    allow_blank: true
  validates :cut_type,
    inclusion: { in: CUT_TYPES },
    allow_blank: true

  after_touch :update_cpue
  after_save :update_cpue



  def self.to_monthly_production_chart
    #Rails.cache.fetch(["to_monthly_production_chart", self.pluck(:id) ], expires_in: 5.minutes) do

      fishes = Fish.where(id: self.pluck(:fish_id).uniq )

      data = fishes.map{ |f|
        {
          name: f.code,
          data: self.
            where( fish_id: f.id ).
            joins(:unloading).
            group_by_month_of_year('unloadings.time_in', format: '%b' ).
            sum(:quantity)
        }
      }
      data
    #end
  end

  def self.to_catch_composition_chart
    catches     = self.group(:fish_id).sum(:quantity)
    catches     = Hash[catches.map{|k,v| [Fish.find(k).code,v]}]
  end

  def self.to_monthly_cpue_chart
    fishes = Fish.where(id: self.pluck(:fish_id).uniq )
    data = fishes.map{ |f|
      {
        name: f.code,
        data: self.
          where( fish_id: f.id ).
          joins(:unloading).
          group_by_month_of_year('unloadings.time_in', format: '%b' ).
          average('unloading_catches.cpue')
        }
      }

    data
  end


private

  def update_cpue

    vol   = self.quantity
    arr   = self.unloading.time_in
    dep   = self.unloading.time_out
    gt    = self.vessel.try(:tonnage)
    unless vol.nil? || arr.nil? || dep.nil?
      dur   = (arr.minus_with_coercion(dep)/3600/24).round+1
      val   = vol / dur / gt rescue false
      update_column(:cpue, val) if val.is_a?( Integer )
    end
  end

end
