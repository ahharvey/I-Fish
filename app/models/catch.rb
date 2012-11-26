class Catch < ActiveRecord::Base
  attr_accessible :fish_id, :length, :weight, :landing_id
  
  belongs_to :fish
  belongs_to :landing
end
