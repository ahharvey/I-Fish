# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  name            :string
#  shark_policy    :boolean
#  iuu_list        :boolean
#  code_of_conduct :boolean
#  member          :boolean
#  avatar          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  code            :string
#

class Company < ActiveRecord::Base
  has_paper_trail

  has_many :documents, as: :documentable
  has_many :vessels
  has_many :unloadings, through: :vessels
  has_many :bait_loadings, through: :vessels
  has_many :carier_loadings, through: :vessels
  has_many :users, through: :company_positions
  has_many :company_positions

  has_and_belongs_to_many :member_fisheries, 
    class_name: "Fishery",
    join_table: "fisheries_companies",
    uniq: true

  validate :avatar_size

  mount_uploader :avatar, AvatarUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :fishery_id
  after_update :crop_avatar
  
  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def has_fishing_vessels?
    vessels.where(vessel_type_id: VesselType.find_by(code: 'pol')).any? || vessels.where(vessel_type_id: VesselType.find_by(code: 'hl')).any? 
  end

  def has_carrier_vessels?
    vessels.where(vessel_type_id: VesselType.find_by(code: 'ca')).any? 
  end

  def bait_fishes
    bait = []
    member_fisheries.each do |fishery|
      bait << fishery.bait_fishes
    end
    bait.first.uniq.sort_by(&:code)
  end

  private
 
  def avatar_size
    errors[:avatar] << "should be less than 1MB" if avatar.size > 1.megabytes
  end
end
