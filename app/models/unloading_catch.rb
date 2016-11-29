# == Schema Information
#
# Table name: unloading_catches
#
#  id           :integer          not null, primary key
#  fish_id      :integer
#  quantity     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  unloading_id :integer
#  cut_type     :string
#

class UnloadingCatch < ApplicationRecord
  belongs_to :fish
  belongs_to :unloading
  belongs_to :size_class

  validates :fish,
  	presence: true
  validates :unloading,
  	presence: true
  validates :quantity,
  	presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 9999
    }

  CUT_TYPES = ["wholeround", "dirtyloin", "cleanloin", "gg"]

  CATCH_TYPES = ['landed', 'discarded']


end
