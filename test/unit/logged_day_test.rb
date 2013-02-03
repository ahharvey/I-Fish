# == Schema Information
#
# Table name: logged_days
#
#  id           :integer          not null, primary key
#  start_time   :datetime
#  end_time     :datetime
#  gear_time    :integer
#  fuel         :integer
#  sail         :boolean
#  net          :boolean
#  line         :boolean
#  quantity     :integer
#  weight       :integer
#  value        :integer
#  condition    :integer
#  moon         :integer
#  fish_id      :integer
#  graticule_id :integer
#  logbook_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  crew         :integer
#

require 'test_helper'

class LoggedDayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
