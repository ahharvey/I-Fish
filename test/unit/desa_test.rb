# == Schema Information
#
# Table name: desas
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  code        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lat         :float
#  lng         :float
#  district_id :integer
#

require 'test_helper'

class DesaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
