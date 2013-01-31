# == Schema Information
#
# Table name: fisheries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fishery < ActiveRecord::Base
  attr_accessible :code, :name
  
  has_many :surveys, dependent: :destroy
  has_many :logbooks

  validates :name,
  	presence: true
  validates :code,
  	presence: true
end
