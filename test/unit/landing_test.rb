# == Schema Information
#
# Table name: landings
#
#  id             :integer          not null, primary key
#  vessel_ref     :string(255)
#  vessel_name    :string(255)
#  boat_size      :integer
#  gear_id        :integer
#  survey_id      :integer
#  quantity       :integer
#  weight         :integer
#  time_out       :datetime
#  time_in        :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  type           :string(255)
#  engine_id      :integer
#  graticule_id   :integer
#  fish_id        :integer
#  cpue           :integer
#  value          :integer
#  cpue_kg        :integer
#  cpue_idr       :integer
#  cpue_fuel      :integer
#  sail           :boolean
#  fuel           :integer
#  power          :integer
#  crew           :integer
#  row            :integer
#  vessel_type_id :integer
#  ice            :integer
#  conditions     :integer
#  aborted        :string(255)
#

require 'test_helper'

class LandingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
