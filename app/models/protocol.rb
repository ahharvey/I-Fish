# == Schema Information
#
# Table name: protocols
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Protocol < ApplicationRecord
  has_many :documents, as: :documentable
  has_many :fisheries
  has_paper_trail
end
