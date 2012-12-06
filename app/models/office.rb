class Office < ActiveRecord::Base
  has_many :admins

  attr_accessible :name
end
