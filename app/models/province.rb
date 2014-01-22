# == Schema Information
#
# Table name: provinces
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alpha_code :string(255)
#

class Province < ActiveRecord::Base
  
  has_paper_trail

  attr_accessible :name, :code, :year
  attr_accessor :year

  has_many :districts
  has_many :desas, through: :districts
  has_many :offices, through: :districts
  has_many :admins, through: :districts
  has_many :surveys, through: :districts
  has_many :landings, through: :surveys
  has_many :catches, through: :landings
  has_many :fisheries, through: :surveys
  has_many :gears, through: :landings
  has_many :fishes, through: :landings

  def approved_surveys
    self.surveys.where( review_state: 'approved' )
  end

end
