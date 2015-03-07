# == Schema Information
#
# Table name: desas
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  code        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lat         :float
#  lng         :float
#  district_id :integer
#

class Desa < ActiveRecord::Base
  
  has_paper_trail
  
  

  has_many :surveys, dependent: :destroy
  has_many :landings, through: :surveys
  has_many :users
  belongs_to :district
  has_one :province, through: :district

  def approved_surveys
    self.surveys.where( review_state: 'approved')
  end

end
