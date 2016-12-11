# == Schema Information
#
# Table name: wpps
#
#  id   :integer          not null, primary key
#  name :string
#

class Wpp < ApplicationRecord
  include HasBaitRatio
  has_many :unloadings
  has_many :unloading_catches, through: :unloadings
	has_many :vessels, through: :unloadings
	has_many :bait_loadings, through: :vessels
  scope :default, -> { order('wpps.name ASC') }
  validates :name,
		presence: true
end
