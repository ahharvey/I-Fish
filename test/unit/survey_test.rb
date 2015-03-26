# == Schema Information
#
# Table name: surveys
#
#  id                    :integer          not null, primary key
#  date_published        :date
#  desa_id               :integer
#  start_time            :datetime
#  end_time              :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  fishery_id            :integer
#  admin_id              :integer
#  reviewer_id           :integer
#  landing_enumerator_id :integer
#  catch_measurer_id     :integer
#  catch_scribe_id       :integer
#  vessel_count          :integer
#  review_state          :string(255)      default("pending")
#  reviewed_at           :datetime
#

require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
