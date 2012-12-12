class Fish < ActiveRecord::Base
  set_table_name "fishes"

  attr_accessible :code, :english_name, :family, :fishbase_name, :indonesia_name, :order, :scientific_name

  has_many :catches, dependent: :destroy
end
