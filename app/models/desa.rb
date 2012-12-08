class Desa < ActiveRecord::Base
  attr_accessible :name, :kabupaten, :code, :lat, :lng

  has_many :surveys, dependent: :destroy
  has_many :users
end
