# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  name            :string
#  shark_policy    :boolean
#  iuu_list        :boolean
#  code_of_conduct :boolean
#  member          :boolean
#  avatar          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  code            :string
#

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
