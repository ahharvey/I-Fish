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

class Unloading < ActiveRecord::Base
  belongs_to :vessel
  belongs_to :grid
  has_many :unloading_catches
  accepts_nested_attributes_for :unloading_catches, allow_destroy: true, reject_if: :all_blank
  has_many :bait_loadings
  accepts_nested_attributes_for :bait_loadings, allow_destroy: true, reject_if: :all_blank

  validates :time_out, 
    timeliness: {
      type: :datetime
    }
  validates :time_in, 
    timeliness: {
      after: :time_out,
      type: :datetime
    }


#  validates :yft, :bet, :skj, :kaw, :byproduct, :discard, :fuel, :ice,
#    presence: {
#      message: " cannot be blank." 
#    },
#    numericality: {
#      message: " is not a number."
#    }



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

  def number_of_bait_loadings
    Rails.cache.fetch(["bait-loadings", self], expires_in: 5.minutes) do
      bait_loadings.length
    end
  end
end
