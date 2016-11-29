# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ApplicationRecord

  has_paper_trail

  validates :name,
  	presence: true,
  	uniqueness: true
end
