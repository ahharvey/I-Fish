class Graticule < ActiveRecord::Base
  attr_accessible :code

  has_many :landings
  has_many :logged_days
end
