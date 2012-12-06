class Desa < ActiveRecord::Base
  attr_accessible :name

  has_many :surveys, dependent: :destroy
  has_many :users
end
