class Desa < ActiveRecord::Base
  attr_accessible :name, :kabupaten, :code
  
  has_many :surveys, dependent: :destroy
end
