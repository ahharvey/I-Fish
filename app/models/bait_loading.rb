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
  attr_writer :formatted_date
  before_validation :save_formatted_date 
  def formatted_date
    @formatted_date || date.try(:to_s, :long)
  end
  
  def save_formatted_date
    self.date = Chronic.parse(@formatted_date) if @formatted_date.present?
  end
end
