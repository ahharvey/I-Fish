# == Schema Information
#
# Table name: bait_loadings
#
#  id           :integer          not null, primary key
#  date         :date
#  vessel_id    :integer
#  location     :string
#  fish_id      :integer
#  quantity     :integer
#  unloading_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class BaitLoading < ActiveRecord::Base
  belongs_to :vessel, touch: true
  belongs_to :fish, touch: true
  belongs_to :unloading, touch: true
  validates :date, 
    timeliness: {
      type: :date
    }
end
