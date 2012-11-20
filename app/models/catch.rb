class Catch < ActiveRecord::Base
  attr_accessible :fish_id, :length, :weight
  
  belongs_to :fish
end
