class Office < ActiveRecord::Base
  attr_accessible :name, :district_id

  has_many :admins
  belongs_to :district
end
