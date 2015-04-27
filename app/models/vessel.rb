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
#  shark_policy       :boolean
#  iuu_list           :boolean
#  code_of_conduct    :boolean
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
#  issf_ref_requested :boolean
#  material_type      :string
#  machine_type       :string
#  capacity           :integer
#  vms                :boolean
#  tracker            :boolean
#  port               :string
#  name_changed       :boolean
#  flag_state_changed :boolean
#  radio              :boolean
#  relationship_type  :string
#  fish_capacity      :integer
#  bait_capacity      :integer
#  location_built     :string
#  seafdec_ref        :string
#  mmaf_ref           :string
#  dkp_ref            :string
#

class Vessel < ActiveRecord::Base
  belongs_to :vessel_type
  belongs_to :gear
  belongs_to :company
  has_many :documents, as: :documentable
  has_many :unloadings

  validates :sipi_expiry, 
    timeliness: {
      type: :date
    }

  has_paper_trail

  attr_accessor :return_to

  before_save :send_pvr_request

  scope :default, -> { order('vessels.ap2hi_ref ASC') }

  MATERIAL_TYPES = ["wood", "fiber"]
  MACHINE_TYPES = ["none", "outboard", "inboard"]
  RELATIONSHIP_TYPES = ["contracted", "independent"]

  
  attr_writer :formatted_sipi_expiry
  before_validation :save_formatted_sipi_expiry 
  def formatted_sipi_expiry
    @formatted_sipi_expiry || sipi_expiry.try(:to_s, :long)
  end
  
  def save_formatted_sipi_expiry
    self.sipi_expiry = Chronic.parse(@formatted_sipi_expiry) if @formatted_sipi_expiry.present?
  end


  private

  def send_pvr_request
    if issf_ref_requested_changed? && issf_ref_requested?
      admins = Admin.pvr_managers
      for admin in admins
        UserMailer.new_pvr_application(self.id, admin.id).deliver_later
      end
    end
  end
end
