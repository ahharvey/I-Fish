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
	acts_as_reviewable

  belongs_to :vessel
  belongs_to :admin
  belongs_to :audit

  scope :default, -> { order('pending_vessels.created_at DESC') }
  scope :pending, -> { where( review_state: 'pending').default.reverse }

  def approve!

    accessible_attributes.each do |k, v|
      unless v.to_s == vessel[k].to_s
        vessel[k] = v.to_s
      end
      k = nil
    end
    vessel.save
    update( review_state: 'rejected' )

  end

  def reject!
  	update( review_state: 'rejected' )
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
	
end
