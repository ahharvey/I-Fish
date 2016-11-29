class SizeClass < ApplicationRecord
	has_many :unloading_catches

	scope :default, -> { order('size_classes.median ASC') }

	before_validation :set_median

	private

	def set_median
		self.median = lower.to_f + (0.5 * ( upper.to_f - lower.to_f ) )
	end
end
