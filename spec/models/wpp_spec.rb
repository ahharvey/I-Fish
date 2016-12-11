# == Schema Information
#
# Table name: wpps
#
#  id   :integer          not null, primary key
#  name :string
#



require 'rails_helper'

RSpec.describe Wpp do



  let(:wpp1) { create :wpp, name: 'BBB' }
  let(:wpp2) { create :wpp, name: 'AAA' }




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
      wpp1
      wpp2
      expect( Wpp.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Wpp.default).to eq([wpp2, wpp1])
    end
  end



  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end



end
