class Catch < ActiveRecord::Base
	attr_accessible :fish_id, :length, :weight, :landing_id

	belongs_to :fish
	belongs_to :landing


	def self.import_from_email(params, user_id)
		params.flatten.each do |param|
			species = param[:code_species] || ''
			length = param[:length] || ''
			weight = param[:weight] || ''
			unless species.blank?
				fish_id = Fish.where("LOWER(code) = ?", code_species).first.id rescue nil

				Catch.create(fish_id: fish_id, length: length, weight: weight)
			end
		end
	end
end
