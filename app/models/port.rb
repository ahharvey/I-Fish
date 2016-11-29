class Port < ApplicationRecord
	has_many :unloadings
  scope :default, -> { order('ports.name ASC') }
end
