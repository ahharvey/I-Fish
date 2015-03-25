class Unloading < ActiveRecord::Base
  belongs_to :vessel
  has_many :unloading_catches
  accepts_nested_attributes_for :unloading_catches, allow_destroy: true, reject_if: :all_blank
  has_many :bait_loadings
  accepts_nested_attributes_for :bait_loadings, allow_destroy: true, reject_if: :all_blank

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

  def formatted_time_out
    time_out.try(:strftime, "%d-%b-%Y %H:%M")
  end

  def formatted_time_in
    time_in.try(:strftime, "%d-%b-%Y %H:%M")
  end

  def number_of_bait_loadings
    Rails.cache.fetch(["bait-loadings", self], expires_in: 5.minutes) do
      bait_loadings.length
    end
  end
end
