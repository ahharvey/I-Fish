class Fish < ActiveRecord::Base
  include ModelBase

  attr_accessible :code, :english_name, :family, :genus, :local_name, :species
  
  has_many :catches, dependent: :destroy
end
