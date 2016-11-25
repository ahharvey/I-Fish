

require 'rails_helper'

RSpec.describe Unloading do



  let(:unloading1) { create :unloading, time_out: Time.now-2.hour, time_in: Time.now-1.hour }
  let(:unloading2) { create :unloading, time_out: Time.now-1.hour, time_in: Time.now }


  it_behaves_like "reviewable"

  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:vessel) }
      it { is_expected.to belong_to(:wpp) }
      it { is_expected.to belong_to(:port) }
      it { is_expected.to belong_to(:user) }
      it {
        is_expected.to belong_to(:reviewer).
          class_name('User')
        }
    end
    context 'has many' do
      it { is_expected.to have_many(:unloading_catches) }
      it { is_expected.to have_many(:bait_loadings) }

      it {
        should accept_nested_attributes_for(:unloading_catches).
          allow_destroy(true)
      }
      it {
        should accept_nested_attributes_for(:bait_loadings).
          allow_destroy(true)
      }
    end
    context 'has one' do
      it { is_expected.to have_one(:company) }
    end
  end


  describe ".default" do
    it "includes all records" do
      unloading1
      unloading2
      expect( Unloading.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( Unloading.default).to eq([unloading2, unloading1])
    end
  end



  describe "validations" do
    it { is_expected.to validate_presence_of(:vessel) }
    it { is_expected.to validate_presence_of(:port) }
    it { is_expected.to validate_presence_of(:wpp) }
  end



end
