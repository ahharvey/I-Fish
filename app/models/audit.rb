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
  belongs_to :user
  belongs_to :auditable, polymorphic: true

  STATES = %w{ approved rejected }

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
