# == Schema Information
#
# Table name: generated_reports
#
#  id         :integer          not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GeneratedReport < ApplicationRecord
	mount_uploader :file, DocumentUploader
end
