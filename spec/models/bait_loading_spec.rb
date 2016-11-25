

require 'rails_helper'

RSpec.describe BaitLoading do



  let(:bait_loading1) { create :bait_loading, date: Time.now-1.hour }
  let(:bait_loading2) { create :bait_loading, date: Time.now }

  it_behaves_like "reviewable"

  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:vessel) }
      it { is_expected.to belong_to(:fish) }
      it {
        is_expected.to belong_to(:secondary_fish).
          class_name('Fish').
          with_foreign_key('secondary_fish_id')
        }
      it { is_expected.to belong_to(:grid) }
      it { is_expected.to belong_to(:unloading) }
      it { is_expected.to belong_to(:bait) }
      it {
        is_expected.to belong_to(:secondary_bait).
          class_name('Bait').
          with_foreign_key('secondary_bait_id')
        }
      it {
        is_expected.to belong_to(:reviewer).
          class_name('User')
        }
    end
  end

  describe ".default" do
    it "includes all records" do
      bait_loading1
      bait_loading2
      expect( BaitLoading.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( BaitLoading.default).to eq([bait_loading2, bait_loading1])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:vessel) }
    it { is_expected.to validate_presence_of(:bait) }
    it { is_expected.to validate_presence_of(:quantity) }
    it {
      is_expected.to validate_numericality_of(:quantity).
        only_integer.
        is_greater_than_or_equal_to(1).
        is_less_than_or_equal_to(999)
    }
    it {
      is_expected.to validate_inclusion_of(:method_type).
        in_array( %w{ bagan purse beach bouke } )
    }

  end



end
