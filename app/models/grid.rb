# == Schema Information
#
# Table name: grids
#
#  id         :integer          not null, primary key
#  xaxis      :integer
#  yaxis      :string(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Grid < ActiveRecord::Base
	validates_uniqueness_of :xaxis, :scope => :yaxis

	has_many :bait_loadings
	has_many :unloadings

	scope :default, -> { order('grids.yaxis ASC, grids.xaxis ASC') }

	def coordinates
		"#{yaxis.upcase}#{xaxis}"
	end
end
