# == Schema Information
#
# Table name: provinces
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alpha_code :string(255)
#

require 'test_helper'

class ProvinceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
