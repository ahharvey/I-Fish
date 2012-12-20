# == Schema Information
#
# Table name: gears
#
#  id          :integer          not null, primary key
#  cat_ind     :string(255)
#  cat_eng     :string(255)
#  sub_cat_ind :string(255)
#  sub_cat_eng :string(255)
#  type_ind    :string(255)
#  type_eng    :string(255)
#  name        :string(255)
#  alpha_code  :string(255)
#  num_code    :string(255)
#  fao_code    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class GearTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
