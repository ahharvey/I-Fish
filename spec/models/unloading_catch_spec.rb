# == Schema Information
#
# Table name: unloading_catches
#
#  id            :integer          not null, primary key
#  fish_id       :integer
#  quantity      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  unloading_id  :integer
#  cut_type      :string
#  catch_type    :string
#  size_class_id :integer
#  cpue          :integer          default(0)
#



require 'rails_helper'

RSpec.describe UnloadingCatch do


  let(:fish1)            { create :fish, code: 'AAA' }
  let(:fish2)            { create :fish, code: 'BBB' }
  let(:unloading1)       { create :unloading, time_out: Date.new(2014,1,1), time_in: Date.new(2014,1,2), vessel: vessel }
  let(:unloading2)       { create :unloading, time_in: Date.today, time_out: Date.today-1.day }
  let(:unloading_catch1) { create :unloading_catch, unloading: unloading1, fish: fish2, quantity: 8 }
  let(:unloading_catch2) { create :unloading_catch, unloading: unloading2, fish: fish1 }
  let(:unloading_catch3) { create :unloading_catch, unloading: unloading1, fish: fish1, quantity: 12 }
  let(:vessel)           { create :vessel, tonnage: 2 }

  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:fish) }
      it { is_expected.to belong_to(:unloading) }
      it { is_expected.to belong_to(:size_class) }
    end
    context 'have one' do
      it { is_expected.to have_one(:vessel).through(:unloading) }
    end
  end

  describe ".default" do
    it "includes all records" do
      unloading_catch1
      unloading_catch2
      expect( UnloadingCatch.default.count).to eq 2
    end
    it "should be ordered by name" do
      expect( UnloadingCatch.default).to eq([unloading_catch2, unloading_catch1])
    end
  end

  describe ".current" do
    before :each do
      unloading_catch1
      unloading_catch2
    end
    it "includes all records" do
      expect( UnloadingCatch.current.count).to eq 1
    end
    it "should be ordered by name" do
      expect( UnloadingCatch.current).to eq([unloading_catch2])
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:fish) }
    it { is_expected.to validate_presence_of(:unloading) }
    it { is_expected.to validate_presence_of(:quantity) }
    it {
      is_expected.to validate_numericality_of(:quantity).
        only_integer.
        is_greater_than_or_equal_to(1).
        is_less_than_or_equal_to(9999)
    }
    it {
      is_expected.to validate_inclusion_of(:cut_type).
        in_array( %w{ wholeround dirtyloin cleanloin gg } )
    }
    it {
      is_expected.to validate_inclusion_of(:catch_type).
        in_array( %w{ landed discarded } )
    }

  end

  describe 'after_touch' do
    it 'updates the cpue' do
      cp = UnloadingCatch.create(unloading_id: unloading1.id, fish_id: fish1.id, quantity: 16)
      expect(cp.cpue).to eq 4
    end
  end

  describe '#to_monthly_production_chart' do
    before :each do
      unloading_catch1
      unloading_catch3
    end
    it {
      expect( UnloadingCatch.to_monthly_production_chart ).to match_array(
        [
          {
            name: fish1.code,
            data: {
              "Jan"=>12,
              "Feb"=>0,
              "Mar"=>0,
              "Apr"=>0,
              "May"=>0,
              "Jun"=>0,
              "Jul"=>0,
              "Aug"=>0,
              "Sep"=>0,
              "Oct"=>0,
              "Nov"=>0,
              "Dec"=>0
            }
          },{
            name: fish2.code,
            data: {
              "Jan"=>8,
              "Feb"=>0,
              "Mar"=>0,
              "Apr"=>0,
              "May"=>0,
              "Jun"=>0,
              "Jul"=>0,
              "Aug"=>0,
              "Sep"=>0,
              "Oct"=>0,
              "Nov"=>0,
              "Dec"=>0
            }
          }
        ]
      )
    }
  end

  describe '#to_catch_composition_chart' do
    before :each do
      unloading_catch1
      unloading_catch3
    end
    it {
      expect( UnloadingCatch.to_catch_composition_chart ).to eq(
        {
          fish1.code => 12,
          fish2.code => 8
        }
      )
    }
  end

  describe '#to_monthly_cpue_chart' do
    before :each do
      unloading_catch1
      unloading_catch3
    end
    it {
      expect( UnloadingCatch.to_monthly_cpue_chart ).to match_array(
        [
          { name: fish1.code,
            data: {
              "Jan"=>3,
              "Feb"=>0,
              "Mar"=>0,
              "Apr"=>0,
              "May"=>0,
              "Jun"=>0,
              "Jul"=>0,
              "Aug"=>0,
              "Sep"=>0,
              "Oct"=>0,
              "Nov"=>0,
              "Dec"=>0
            }
          },{
            name: fish2.code,
            data: {
              "Jan"=>2,
              "Feb"=>0,
              "Mar"=>0,
              "Apr"=>0,
              "May"=>0,
              "Jun"=>0,
              "Jul"=>0,
              "Aug"=>0,
              "Sep"=>0,
              "Oct"=>0,
              "Nov"=>0,
              "Dec"=>0
            }
          }
        ]
      )
    }
  end

end
