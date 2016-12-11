# == Schema Information
#
# Table name: fisheries
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  code         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  protocol_id  :integer
#  draft_id     :integer
#  published_at :datetime
#  trashed_at   :datetime
#



require 'rails_helper'

RSpec.describe Admin do



  let(:admin1) { create :admin, name: 'BBB', approved: true }
  let(:admin2) { create :admin, name: 'AAA', approved: false }

  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:office) }
    end
    context 'has many' do
      it { is_expected.to have_many(:team_members).through(:office).source(:admins) }
      it { is_expected.to have_many(:member_fisheries).through(:office) }
      it { is_expected.to have_many(:member_companies).through(:member_vessels).source(:company) }
      it { is_expected.to have_many(:member_vessels).through(:member_fisheries).source(:vessels) }
      it { is_expected.to have_many(:member_unloadings).through(:member_vessels).source(:unloadings) }
      it { is_expected.to have_many(:member_unloading_catches).through(:member_unloadings).source(:unloading_catches) }
      it { is_expected.to have_many(:member_bait_loadings).through(:member_vessels).source(:bait_loadings) }
    end
    context 'has and belongs to' do
      it { is_expected.to have_and_belong_to_many(:roles) }
    end
  end

  describe ".default" do
    it "includes all records" do
      admin1
      admin2
      expect( Admin.default.count).to eq 2
      expect( Admin.default).to eq([admin2, admin1])
    end
  end

  describe ".pending" do
    it "includes all records" do
      admin1
      admin2
      expect( Admin.pending.count).to eq 1
      expect( Admin.pending).to eq([admin2])
    end
  end

  describe ".approved" do
    it "includes all records" do
      admin1
      admin2
      expect( Admin.approved.count).to eq 1
      expect( Admin.approved).to eq([admin1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:office) }
  end

end
