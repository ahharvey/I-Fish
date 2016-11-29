# == Schema Information
#
# Table name: carrier_loadings
#
#  id           :integer          not null, primary key
#  date         :date
#  vessel_id    :integer
#  fish_id      :integer
#  location     :string
#  size         :string
#  grade        :string
#  quantity     :integer
#  review_state :string           default("pending")
#  string       :string           default("pending")
#

class CarrierLoading < ApplicationRecord
	belongs_to :vessel, touch: true
  belongs_to :fish, touch: true

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
  def formatted_date
    @formatted_date || date.try(:to_s, :long)
  end

  def save_formatted_date
    self.date = Chronic.parse(@formatted_date) if @formatted_date.present?
  end
end
