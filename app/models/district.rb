# == Schema Information
#
# Table name: districts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  province_id :integer
#  code        :integer
#

class District < ActiveRecord::Base
  
  has_paper_trail

  attr_accessible :name, :province_id, :code, :year
  attr_accessor :year

  has_many :desas
  has_many :offices
  has_many :admins, through: :offices
  has_many :surveys, through: :desas
  has_many :landings, through: :surveys
  has_many :catches, through: :landings
  has_many :gears, through: :landings
  has_many :fisheries, through: :surveys
  has_many :fishes, through: :landings
  has_many :engines, through: :landings

  belongs_to :province

  validates :name,
  	presence: true

  def approved_surveys
    self.surveys.where( review_state: 'approved' )
  end
  
end
