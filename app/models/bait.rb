# == Schema Information
#
# Table name: baits
#
#  id   :integer          not null, primary key
#  name :string
#  code :string
#

class Bait < ApplicationRecord
	has_many :bait_loadings
end
