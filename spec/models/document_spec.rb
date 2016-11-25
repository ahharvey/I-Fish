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

RSpec.describe Document do



  let(:document1) { create :document, created_at: Time.now-1.hour }
  let(:document2) { create :document, created_at: Time.now }


  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:documentable) }
    end
  end

  describe ".default" do
    it "includes all records" do
      document1
      document2
      expect( Document.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Document.default).to eq([document2, document1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:file) }
    it { is_expected.to validate_presence_of(:documentable) }
  end


end
