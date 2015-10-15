class Port < ActiveRecord::Base
	has_many :unloadings 
  scope :default, -> { order('ports.name ASC') }
end