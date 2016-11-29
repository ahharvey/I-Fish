class Wpp < ApplicationRecord
  has_many :unloadings
  scope :default, -> { order('wpps.name ASC') }
end
