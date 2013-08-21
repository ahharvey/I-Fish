# == Schema Information
#
# Table name: surveys
#
#  id             :integer          not null, primary key
#  date_published :date
#  desa_id        :integer
#  start_time     :datetime
#  end_time       :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  fishery_id     :integer
#  fleet_observer :string(255)
#  catch_scribe   :string(255)
#  catch_measure  :string(255)
#  admin_id       :integer
#  approved       :boolean          default(FALSE), not null
#  approver_id    :integer
#

require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
