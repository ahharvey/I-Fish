class Graticule < ActiveRecord::Base
  attr_accessible :code

  has_many :landings
end
