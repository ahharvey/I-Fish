# == Schema Information
#
# Table name: vessel_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  code       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VesselType < ActiveRecord::Base
  
  has_paper_trail

  has_many :landings
end
