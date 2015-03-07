# == Schema Information
#
# Table name: engines
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Engine < ActiveRecord::Base
  
  has_paper_trail

  has_many :landings
  has_many :districts, through: :landings

  def approved_landings
    self.landings.where(survey_id: Survey.where(approved: true))
  end
end
