# == Schema Information
#
# Table name: pending_vessels
#
#  id                 :integer          not null, primary key
#  name               :string
#  vessel_type_id     :integer
#  gear_id            :integer
#  flag_state         :string
#  year_built         :string
#  length             :integer
#  tonnage            :integer
#  company_id         :integer
#  crew               :integer
#  hooks              :integer
#  captain            :string
#  owner              :string
#  sipi_number        :string
#  sipi_expiry        :date
#  siup_number        :string
#  material_type      :string
#  machine_type       :string
#  capacity           :integer
#  vms                :boolean
#  tracker            :boolean
#  port               :string
#  name_changed       :boolean
#  flag_state_changed :boolean
#  radio              :string
#  relationship_type  :string
#  fish_capacity      :integer
#  bait_capacity      :integer
#  location_built     :string
#  status             :string
#  admin_id           :integer
#  vessel_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class PendingVessel <  ActiveRecord::Base
	acts_as_vessel
  belongs_to :vessel

  scope :default, -> { order('pending_vessels.created_at DESC') }
end
