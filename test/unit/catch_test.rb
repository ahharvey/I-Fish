# == Schema Information
#
# Table name: catches
#
#  id          :integer          not null, primary key
#  fish_id     :integer
#  landing_id  :integer
#  length      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sfactor     :string(255)
#  row         :integer
#  measurement :string(255)
#

require 'test_helper'

class CatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
