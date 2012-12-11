class District < ActiveRecord::Base
  attr_accessible :name

  has_many :desas
  has_many :offices
end
