# == Schema Information
#
# Table name: offices
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  district_id :integer
#

class Office < ActiveRecord::Base
  attr_accessible :name, :district_id

  has_many :admins
  belongs_to :district

  validates :name,
  	presence: true
end
