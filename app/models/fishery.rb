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
  
  has_paper_trail

  attr_accessible :code, :name
  
  has_many :surveys, dependent: :destroy
  has_many :landings, through: :surveys
  has_many :gears, through: :landings
  has_many :fishes, through: :landings
  has_many :engines, through: :landings
  has_many :logbooks
  has_many :logged_days, through: :logbook
  has_many :provinces, through: :surveys
  has_many :districts, through: :surveys



  validates :name,
  	presence: true
  validates :code,
  	presence: true

  def approved_surveys
    self.surveys.where(approved: true)
  end
end
