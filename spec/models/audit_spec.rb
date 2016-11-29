# == Schema Information
#
# Table name: prereps
#
#  id            :integer          not null, primary key
#  date          :date
#  guide         :string(255)
#  lat           :string(255)
#  lon           :string(255)
#  count         :integer
#  grpsize       :integer
#  depth         :integer
#  temp          :integer
#  notes         :text
#  user_id       :integer
#  operator_id   :integer
#  divesite_id   :integer
#  current_code  :integer
#  behavior_mask :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  published     :boolean
#  boats         :integer
#  manta_mask    :integer
#  time          :time
#  weather_code  :integer
#  sea_code      :integer
#  visibility    :integer
#

require 'rails_helper'

RSpec.describe Audit do



  let(:audit1) { create :audit, created_at: Time.now-1.minute }
  let(:audit2) { create :audit, created_at: Time.now }


  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:admin) }
      it { is_expected.to belong_to(:auditable) }
    end
  end

  describe ".default" do
    it "includes all records" do
      audit1
      audit2
      expect( Audit.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Audit.default).to eq([audit2, audit1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:admin) }
    it { is_expected.to validate_presence_of(:auditable) }
    it {
      is_expected.to validate_inclusion_of(:status).
        in_array( %w{ approved rejected reviewed } )
    }
  end


end
