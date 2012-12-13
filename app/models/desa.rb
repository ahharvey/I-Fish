class Desa < ActiveRecord::Base
  attr_accessible :name, :kabupaten, :code, :lat, :lng, :district_id

  has_many :surveys, dependent: :destroy
  has_many :users
  belongs_to :district

  acts_as_gmappable :lat => 'lat', 
                    :lng => 'lng',
                    :process_geocoding => false

end
