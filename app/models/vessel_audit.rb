# == Schema Information
#
# Table name: vessels
#
#  id                 :integer          not null, primary key
#  name               :string
#  vessel_type_id     :integer
#  gear_id            :integer
#  flag_state         :string
#  year_built         :string
#  length             :integer
#  tonnage            :integer
#  imo_number         :string
#  shark_policy       :boolean          default(FALSE)
#  iuu_list           :boolean          default(FALSE)
#  code_of_conduct    :boolean          default(FALSE)
#  company_id         :integer
#  ap2hi_ref          :string
#  issf_ref           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  crew               :integer
#  hooks              :integer
#  captain            :string
#  owner              :string
#  sipi_number        :string
#  sipi_expiry        :date
#  siup_number        :string
#  issf_ref_requested :boolean          default(FALSE)
#  material_type      :string
#  machine_type       :string
#  capacity           :integer
#  vms                :boolean          default(FALSE)
#  tracker            :boolean          default(FALSE)
#  port               :string
#  name_changed       :boolean          default(FALSE)
#  flag_state_changed :boolean          default(FALSE)
#  radio              :boolean          default(FALSE)
#  relationship_type  :string
#  fish_capacity      :integer
#  bait_capacity      :integer
#  location_built     :string
#  seafdec_ref        :string
#  mmaf_ref           :string
#  dkp_ref            :string
#  status             :string
#  operational_type   :string
#  draft_id           :integer
#  published_at       :datetime
#  trashed_at         :datetime
#

class VesselAudit < Vessel
  belongs_to :vessel
end
