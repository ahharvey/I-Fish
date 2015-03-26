# == Schema Information
#
# Table name: documents
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  file              :string
#  content_type      :string
#  file_size         :string
#  documentable_id   :integer
#  documentable_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
