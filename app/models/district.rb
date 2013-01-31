# == Schema Information
#
# Table name: districts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  province_id :integer
#

class District < ActiveRecord::Base
  attr_accessible :name, :province_id

  has_many :desas
  has_many :offices
  has_many :admins, through: :offices
  has_many :surveys, through: :desas

  belongs_to :province

  validates :name,
  	presence: true
end
