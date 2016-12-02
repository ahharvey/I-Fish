

require 'rails_helper'

RSpec.describe Fishery do



  let(:fishery1) { create :fishery, name: 'BBB' }
  let(:fishery2) { create :fishery, name: 'AAA' }

  describe 'associations' do
    context 'has many' do

      it { is_expected.to have_many(:vessels).through(:member_companies) }
      it { is_expected.to have_many(:unloadings).through(:vessels) }
      it { is_expected.to have_many(:unloading_catches).through(:unloadings) }
      it { is_expected.to have_many(:bait_loadings).through(:vessels) }
    end
  end

  describe ".default" do
    it "includes all records" do
      fishery1
      fishery2
      expect( Fishery.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Fishery.default).to eq([fishery2, fishery1])
    end
  end



  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:code) }
  end



end
