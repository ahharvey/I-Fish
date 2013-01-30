class Province < ActiveRecord::Base
  attr_accessible :name, :code

  has_many :districts
  has_many :offices, through: :districts
  has_many :admins, through: :districts

end
