

require 'rails_helper'

RSpec.describe Port do



  let(:port1) { create :port, name: 'BBB' }
  let(:port2) { create :port, name: 'AAA' }


  

  describe 'associations' do
    context 'has many' do
      it { is_expected.to have_many(:unloadings) }
      it { is_expected.to have_many(:vessels).through(:unloadings) }
      it { is_expected.to have_many(:unloading_catches).through(:unloadings) }
      it { is_expected.to have_many(:bait_loadings).through(:vessels) }
    end
  end


  describe ".default" do
    it "includes all records" do
      port1
      port2
      expect( Port.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Port.default).to eq([port2, port1])
    end
  end



  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end



end
