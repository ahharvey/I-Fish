class Desa < ActiveRecord::Base
  attr_accessible :name, :kabupaten
  
  has_many :surveys, dependent: :destroy
end
