# == Schema Information
#
# Table name: offices
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  district_id :integer
#

class Office < ApplicationRecord

  has_paper_trail

  # attr_accessible :name, :district_id
  scope :default, -> { order('offices.name ASC') }

  has_many :admins
  belongs_to :district
  has_one :province, through: :district

  has_and_belongs_to_many :member_fisheries, class_name: "Fishery"

  attr_accessor :fishery_id

  validates :name,
  	presence: true

  def supervisors
    Rails.cache.fetch([self, "supvervisors"], expires_in: 5.minutes) do
      Admin.joins(:roles).where(roles: {name: ["supervisor", "leader", "administrator"]}).where(office_id: self.id)
    end
  end
end
