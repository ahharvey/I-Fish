# == Schema Information
#
# Table name: desas
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  code        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lat         :float
#  lng         :float
#  district_id :integer
#

class Desa < ActiveRecord::Base
  
  has_paper_trail
  
  attr_accessible :name, :kabupaten, :code, :lat, :lng, :district_id

  has_many :surveys, dependent: :destroy
  has_many :landings, through: :surveys
  has_many :users
  belongs_to :district
  has_one :province, through: :district

  acts_as_gmappable :lat => 'lat', 
                    :lng => 'lng',
                    :process_geocoding => false

end
