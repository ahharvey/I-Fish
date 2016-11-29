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

RSpec.describe Office do



  let(:office1) { create :office, name: 'BB' }
  let(:office2) { create :office, name: 'AA' }


  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to have_many(:admins) }
      it { is_expected.to have_and_belong_to_many(:member_fisheries) }
    end
  end

  describe ".default" do
    it "includes all records" do
      office1
      office2
      expect( Office.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Office.default).to eq([office2, office1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end


end
