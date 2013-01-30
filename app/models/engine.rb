class Engine < ActiveRecord::Base
  attr_accessible :name, :code

  has_many :landings
end
