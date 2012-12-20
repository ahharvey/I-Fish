# == Schema Information
#
# Table name: offices
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  district_id :integer
#

require 'test_helper'

class OfficeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
