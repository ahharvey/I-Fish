# == Schema Information
#
# Table name: catches
#
#  id         :integer          not null, primary key
#  fish_id    :integer
#  landing_id :integer
#  length     :integer
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Catch < ActiveRecord::Base
	attr_accessible :fish_id, :length, :weight, :landing_id

	belongs_to :fish
	belongs_to :landing
	has_one :survey, through: :landing

	validates :fish_id,
		presence: true
	validates :landing_id,
		presence: true
	validates :length,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..9999
		}
	validates :weight,
		presence: true,
		numericality: {
			only_integer: true
		},
		inclusion: {
			in: 1..999999
		}

	


	def self.import_from_email(params, user_id)
		params.flatten.each do |param|
			species = param[:code_species] || ''
			length = param[:length] || ''
			weight = param[:weight] || ''
			unless species.blank?
				fish_id = Fish.where("LOWER(code) = ?", code_species).first.id rescue nil

				puts Catch.create(fish_id: fish_id, length: length, weight: weight)
			end
		end
	end
end
