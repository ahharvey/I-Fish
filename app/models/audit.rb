# == Schema Information
#
# Table name: audits
#
#  id             :integer          not null, primary key
#  admin_id       :integer
#  auditable_id   :integer
#  auditable_type :string
#  comment        :text
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Audit < ActiveRecord::Base
  belongs_to :admin
  belongs_to :auditable, polymorphic: true
  has_one :pending_vessel

  scope :default, -> { order('audits.created_at DESC') }

  STATES = %w{ approved rejected reviewed}

  STATES.each do |state|
    define_method("#{state}?") do
      self.status == state
    end

    define_method("#{state}!") do
      self.update_attributes(
        status: state
        )
    end
  end
end
