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

require 'test_helper'

class UnloadingCatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
