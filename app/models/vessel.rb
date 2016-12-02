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

class Vessel < ApplicationRecord
  acts_as_vessel
  has_drafts

  has_one :pending_vessel # Or has_many, see the last paragraph

  has_many :documents, as: :documentable
  has_many :unloadings
  has_many :unloading_catches, through: :unloadings
  has_many :bait_loadings
  has_many :audits, as: :auditable

  before_save :send_pvr_request

  scope :default, -> { order('vessels.ap2hi_ref ASC') }

  validates :ap2hi_ref,
  	presence: true

  def bait_fishes
    company.try(:bait_fishes)
  end

  def accessible_attributes
    attributes.except(
      'id',
      'created_at',
      'updated_at',
      'audit_id',
      'admin_id',
      'vessel_id',
      'review_state',
      'reviewed_at'
      )
  end

  def auditable_attributes
    attributes.except(
      'id',
      'created_at',
      'updated_at',
      'audit_id',
      'admin_id',
      'vessel_id',
      'review_state',
      'reviewed_at',
      'imo_number',
      'shark_policy',
      'iuu_list',
      'code_of_conduct',
      'ap2hi_ref',
      'issf_ref',
      'issf_ref_requested',
      'seafdec_ref',
      'mmaf_ref',
      'dkp_ref'
      )
  end

  def attributes_for_import_email

    company   = Company.find( companuy_id ).name    rescue 'none'
    port      = Port.find( port_id ).name           rescue 'none'

    {
      name: name,
      name_changed: name_changed,
      captain: captain,
      owner: owner,
      company: company,
      port: port,
      relationship_type: relationship_type,
      length: length,
      tonnage: tonnage,
      material_type: material_type,
      machine_type: machine_type,
      capacity: capacity,
      flag_state: flag_state,
      flag_state_changed: flag_state_changed,
      year_built: year_built,
      crew: crew,
      hooks: hooks,
      sipi_number: sipi_number,
      sipi_expiry: sipi_expiry,
      siup_number: siup_number,
      radio: radio,
      vms: vms,
      tracker: tracker
    }
  end

  def pending_vessel
    super || build_pending_vessel
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |vessel|
        csv << vessel.attributes.values_at(*column_names)
      end
    end
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

  def self.accessible_attributes
   [
      'name',
      'name_changed',
      'captain',
      'owner',
      'company_id',
      'port',
      'relationship_type',
      'length',
      'tonnage',
      'material_type',
      'machine_type',
      'capacity',
      'flag_state',
      'flag_state_changed',
      'year_built',
      'crew',
      'hooks',
      'sipi_number',
      'sipi_expiry',
      'siup_number',
      'radio',
      'vms',
      'tracker',
    ]
  end




end
