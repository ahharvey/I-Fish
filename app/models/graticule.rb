# == Schema Information
#
# Table name: graticules
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Graticule < ActiveRecord::Base
  attr_accessible :code

  has_many :landings
  has_many :logged_days
end
