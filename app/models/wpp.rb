class Wpp < ActiveRecord::Base
  has_many :unloadings 
  scope :default, -> { order('wpps.name ASC') }
end
  