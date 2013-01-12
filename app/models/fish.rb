# == Schema Information
#
# Table name: fishes
#
#  id              :integer          not null, primary key
#  order           :string(255)
#  family          :string(255)
#  scientific_name :string(255)
#  fishbase_name   :string(255)
#  english_name    :string(255)
#  indonesia_name  :string(255)
#  code            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Fish < ActiveRecord::Base
  set_table_name "fishes"

  attr_accessible :code, :english_name, :family, :fishbase_name, :indonesia_name, :order, :scientific_name

  has_many :catches, dependent: :destroy
  has_many :logged_days
  has_many :landings

  validates :code,
  	presence: true
  validates :order,
  	presence: true
  validates :family,
  	presence: true
  validates :scientific_name,
  	presence: true
  validates :english_name,
  	presence: true

end
