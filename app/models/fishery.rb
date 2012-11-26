class Fishery < ActiveRecord::Base
  attr_accessible :code, :name
  
  has_many :surveys, dependent: :destroy
end
