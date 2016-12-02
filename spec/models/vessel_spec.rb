

require 'rails_helper'

RSpec.describe Vessel do



  let(:vessel1) { create :vessel, ap2hi_ref: 'BBB' }
  let(:vessel2) { create :vessel, ap2hi_ref: 'AAA' }

  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:company) }
    end
    context 'has many' do
      it { is_expected.to have_many(:unloadings) }
      it { is_expected.to have_many(:bait_loadings) }
      it { is_expected.to have_many(:unloading_catches).through(:unloadings) }
      it { is_expected.to have_many(:audits) }
      it { is_expected.to have_many(:documents) }
    end
  end


  describe ".default" do
    it "includes all records" do
      vessel1
      vessel2
      expect( Vessel.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Vessel.default).to eq([vessel2, vessel1])
    end
  end



  describe "validations" do
    it { is_expected.to validate_presence_of(:ap2hi_ref) }
  end



end
