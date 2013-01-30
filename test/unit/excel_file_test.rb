# == Schema Information
#
# Table name: excel_files
#
#  id         :integer          not null, primary key
#  filename   :string(255)
#  filesize   :string(255)
#  file       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :integer
#

require 'test_helper'

class ExcelFileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
