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

class UnloadingCatch < ActiveRecord::Base
  belongs_to :fish
  belongs_to :unloading

  CUT_TYPES = ["wholeround", "dirtyloin", "cleanloin"]

end
