# == Schema Information
#
# Table name: audits
#
#  id             :integer          not null, primary key
#  admin_id       :integer
#  auditable_id   :integer
#  auditable_type :string
#  comment        :text
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class AuditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
