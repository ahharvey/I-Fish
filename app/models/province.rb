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
  attr_accessible :name, :code

  has_many :districts
  has_many :desas, through: :districts
  has_many :offices, through: :districts
  has_many :admins, through: :districts
  has_many :surveys, through: :districts
  has_many :fisheries, through: :surveys

end
