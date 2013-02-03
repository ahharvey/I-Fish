# == Schema Information
#
# Table name: logbooks
#
#  id         :integer          not null, primary key
#  date       :date
#  admin_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fishery_id :integer
#

require 'test_helper'

class LogbookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
