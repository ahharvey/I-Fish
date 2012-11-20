class Gear < ActiveRecord::Base
  attr_accessible :code, :name
  
  has_many :landings, dependent: :destroy
end
