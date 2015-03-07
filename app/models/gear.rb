# == Schema Information
#
# Table name: gears
#
#  id          :integer          not null, primary key
#  cat_ind     :string(255)
#  cat_eng     :string(255)
#  sub_cat_ind :string(255)
#  sub_cat_eng :string(255)
#  type_ind    :string(255)
#  type_eng    :string(255)
#  name        :string(255)
#  alpha_code  :string(255)
#  num_code    :string(255)
#  fao_code    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Gear < ActiveRecord::Base
  
  has_paper_trail

  # default_scope order('num_code ASC')
  default_scope -> { order('num_code ASC') }
  has_many :landings, dependent: :destroy
  has_many :provinces, through: :landings
  has_many :districts, through: :landings
  has_many :fisheries, through: :landings

  has_and_belongs_to_many :using_fisheries, class_name: "Fishery"

  attr_accessor :fishery_id

  def approved_landings
    self.landings.where(survey_id: Survey.where(approved: true))
  end
end
