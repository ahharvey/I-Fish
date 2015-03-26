# == Schema Information
#
# Table name: bait_loadings
#
#  id           :integer          not null, primary key
#  date         :date
#  vessel_id    :integer
#  location     :string
#  fish_id      :integer
#  quantity     :integer
#  unloading_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class BaitLoadingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
