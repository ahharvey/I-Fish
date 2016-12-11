# == Schema Information
#
# Table name: ports
#
#  id   :integer          not null, primary key
#  name :string
#

class Port < ApplicationRecord
	include HasBaitRatio
	has_many :unloadings
	has_many :unloading_catches, through: :unloadings
	has_many :vessels, through: :unloadings
	has_many :bait_loadings, through: :vessels
  scope :default, -> { order('ports.name ASC') }
	validates :name,
		presence: true
end
