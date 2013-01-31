# == Schema Information
#
# Table name: landings
#
#  id           :integer          not null, primary key
#  power        :string(255)
#  vessel_ref   :string(255)
#  vessel_name  :string(255)
#  fuel         :string(255)
#  sail         :string(255)
#  crew         :string(255)
#  value        :string(255)
#  boat_size    :integer
#  gear_id      :integer
#  survey_id    :integer
#  quantity     :integer
#  weight       :integer
#  time_out     :datetime
#  time_in      :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  type         :string(255)
#  engine_id    :integer
#  graticule_id :integer
#  fish_id      :integer
#

require 'test_helper'

class LandingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
