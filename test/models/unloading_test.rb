# == Schema Information
#
# Table name: unloadings
#
#  id                :integer          not null, primary key
#  port              :string
#  time_out          :datetime
#  time_in           :datetime
#  etp               :boolean
#  location          :string
#  fuel              :integer
#  ice               :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  vessel_id         :integer
#  review_state      :string           default("pending")
#  byproduct         :integer
#  discard           :integer
#  yft               :integer
#  bet               :integer
#  skj               :integer
#  kaw               :integer
#  catch_certificate :string
#  budget            :integer
#  grid_id           :integer
#

require 'test_helper'

class UnloadingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
